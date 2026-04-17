import Foundation
import DamagochiCore

public final class ClaudeSessionMonitor: Sendable {
    private let claudeDir: String

    public init(claudeDir: String = NSHomeDirectory() + "/.claude") {
        self.claudeDir = claudeDir
    }

    public var sessionsPath: String {
        claudeDir + "/sessions"
    }

    public var claudeDirectoryExists: Bool {
        FileManager.default.fileExists(atPath: claudeDir)
    }
}
