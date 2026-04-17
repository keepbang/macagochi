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

    @Argument(help: "Event type: prompt, tool, session")
    var eventType: String

    func run() throws {
        let kind: EventKind
        switch eventType {
        case "prompt": kind = .prompt
        case "tool": kind = .toolUse
        case "session": kind = .sessionStart
        default:
            throw ValidationError("Unknown event type: \(eventType). Use: prompt, tool, session")
        }

        let event = BehaviorEvent(kind: kind)
        let data = try JSONEncoder().encode(event)
        let payload = String(data: data, encoding: .utf8) ?? ""
        print(payload)
    }
}
