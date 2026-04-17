import Foundation

public enum EventKind: String, Codable, Sendable {
    case prompt
    case toolUse
    case sessionStart
}

public struct BehaviorEvent: Codable, Sendable {
    public let kind: EventKind
    public let timestamp: Date
    public let metadata: [String: String]?

    public init(kind: EventKind, timestamp: Date = Date(), metadata: [String: String]? = nil) {
        self.kind = kind
        self.timestamp = timestamp
        self.metadata = metadata
    }
}
