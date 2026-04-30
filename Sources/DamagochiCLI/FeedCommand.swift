import ArgumentParser
import Foundation
import DamagochiCore

@main
struct DamagochiCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "damagochi",
        abstract: "Damagochi CLI helper for Claude Code hooks",
        subcommands: [Feed.self]
    )
}

struct Feed: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Feed an event to the Damagochi pet"
    )

    @Argument(help: "Event type: prompt, tool, session, stop, notification")
    var eventType: String

    func run() throws {
        let kind: EventKind
        var metadata: [String: String] = [:]

        switch eventType {
        case "prompt":
            kind = .prompt
            let hour = Calendar.current.component(.hour, from: Date())
            metadata["hour"] = "\(hour)"

        case "tool":
            kind = .toolUse
            // Claude Code가 PostToolUse hook에 stdin으로 JSON 전달
            if let data = readStdin(),
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                let toolName = json["tool_name"] as? String
                    ?? json["toolName"] as? String
                    ?? json["tool"] as? String
                if let toolName {
                    metadata["tool"] = toolName
                }
                if let count = json["unique_tool_count"] as? Int {
                    metadata["uniqueToolCount"] = "\(count)"
                }
            }

        case "session":
            kind = .sessionStart
            // 마지막 세션 시간을 UserDefaults로 추적
            let key = "damagochi.lastSessionStart"
            let now = Date().timeIntervalSince1970
            if let last = UserDefaults.standard.object(forKey: key) as? Double {
                let minutes = (now - last) / 60
                metadata["sessionInterval"] = "\(Int(minutes))"
            }
            UserDefaults.standard.set(now, forKey: key)

        case "stop":
            kind = .stop

        case "notification":
            kind = .notification
            // Claude Code의 Notification hook은 stdin으로 message를 포함한 JSON을 보냄
            if let data = readStdin(),
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let message = json["message"] as? String {
                metadata["message"] = message
            }

        default:
            throw ValidationError("Unknown event type: \(eventType). Use: prompt, tool, session, stop, notification")
        }

        let event = BehaviorEvent(kind: kind, metadata: metadata.isEmpty ? nil : metadata)
        EventBridge.post(event: event)
    }

    private func readStdin() -> Data? {
        // stdin이 터미널이면 읽지 않음 (파이프 입력만 처리)
        if isatty(STDIN_FILENO) != 0 { return nil }
        return FileHandle.standardInput.readDataToEndOfFile()
    }
}
