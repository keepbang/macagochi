import Foundation

public final class FileSystemWatcher: @unchecked Sendable {
    public enum Event: Sendable {
        case write
        case delete
        case rename
        case attrib
    }

    public typealias Handler = @Sendable (Event) -> Void

    private let path: String
    private let handler: Handler
    private let queue: DispatchQueue
    private var source: DispatchSourceFileSystemObject?
    private var fileDescriptor: Int32 = -1

    public init(path: String, queue: DispatchQueue = .global(qos: .utility), handler: @escaping Handler) {
        self.path = path
        self.handler = handler
        self.queue = queue
    }

    deinit {
        stop()
    }

    public func start() -> Bool {
        guard source == nil else { return true }

        fileDescriptor = open(path, O_EVTONLY)
        guard fileDescriptor >= 0 else { return false }

        let mask: DispatchSource.FileSystemEvent = [.write, .delete, .rename, .attrib]
        let src = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: mask,
            queue: queue
        )

        src.setEventHandler { [weak self] in
            guard let self else { return }
            let flags = src.data
            if flags.contains(.write) { self.handler(.write) }
            if flags.contains(.delete) { self.handler(.delete) }
            if flags.contains(.rename) { self.handler(.rename) }
            if flags.contains(.attrib) { self.handler(.attrib) }
        }

        src.setCancelHandler { [weak self] in
            guard let self else { return }
            if self.fileDescriptor >= 0 {
                close(self.fileDescriptor)
                self.fileDescriptor = -1
            }
        }

        src.resume()
        self.source = src
        return true
    }

    public func stop() {
        source?.cancel()
        source = nil
    }

    public var isWatching: Bool {
        source != nil
    }
}
