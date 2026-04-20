import Foundation

public enum EventBridge: Sendable {
    public static let notificationName = "com.damagochi.feedEvent"
    public static let eventFileDir = NSHomeDirectory() + "/.damagochi"
    public static let eventFilePath = eventFileDir + "/pending-events.jsonl"

    public static func post(event: BehaviorEvent) {
        let center = DistributedNotificationCenter.default()
        let data = try? JSONEncoder().encode(event)
        let payload = data.flatMap { String(data: $0, encoding: .utf8) }
        center.postNotificationName(
            NSNotification.Name(notificationName),
            object: nil,
            userInfo: payload.map { ["event": $0] },
            deliverImmediately: true
        )
        appendToFile(event: event)
    }

    public static func observe(handler: @escaping @Sendable (BehaviorEvent) -> Void) -> NSObjectProtocol {
        let center = DistributedNotificationCenter.default()
        return center.addObserver(
            forName: NSNotification.Name(notificationName),
            object: nil,
            queue: .main
        ) { notification in
            guard let payload = notification.userInfo?["event"] as? String,
                  let data = payload.data(using: .utf8),
                  let event = try? JSONDecoder().decode(BehaviorEvent.self, from: data)
            else { return }
            handler(event)
        }
    }

    public static func removeObserver(_ observer: NSObjectProtocol) {
        DistributedNotificationCenter.default().removeObserver(observer)
    }

    private static func appendToFile(event: BehaviorEvent) {
        let fm = FileManager.default
        if !fm.fileExists(atPath: eventFileDir) {
            try? fm.createDirectory(atPath: eventFileDir, withIntermediateDirectories: true)
        }
        guard let data = try? JSONEncoder().encode(event),
              var line = String(data: data, encoding: .utf8) else { return }
        line += "\n"
        if fm.fileExists(atPath: eventFilePath) {
            guard let handle = FileHandle(forWritingAtPath: eventFilePath) else { return }
            handle.seekToEndOfFile()
            handle.write(Data(line.utf8))
            handle.closeFile()
        } else {
            try? line.write(toFile: eventFilePath, atomically: true, encoding: .utf8)
        }
    }

    public static func drainFileEvents() -> [BehaviorEvent] {
        let fm = FileManager.default
        guard fm.fileExists(atPath: eventFilePath),
              let content = try? String(contentsOfFile: eventFilePath, encoding: .utf8)
        else { return [] }

        try? fm.removeItem(atPath: eventFilePath)

        let decoder = JSONDecoder()
        return content
            .split(separator: "\n")
            .compactMap { line in
                guard let data = line.data(using: .utf8) else { return nil }
                return try? decoder.decode(BehaviorEvent.self, from: data)
            }
    }
}
