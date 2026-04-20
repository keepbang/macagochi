import Testing
import Foundation
@testable import DamagochiMonitor
@testable import DamagochiCore

@Test func monitorInitialization() {
    let monitor = ClaudeSessionMonitor(claudeDir: "/tmp/test-claude")
    #expect(monitor.sessionsPath == "/tmp/test-claude/sessions")
    #expect(monitor.statsFilePath == "/tmp/test-claude/.session-stats.json")
}

@Test func monitorDetectsClaudeDirectory() {
    let monitor = ClaudeSessionMonitor(claudeDir: "/tmp")
    #expect(monitor.claudeDirectoryExists)

    let missing = ClaudeSessionMonitor(claudeDir: "/tmp/nonexistent-\(UUID().uuidString)")
    #expect(!missing.claudeDirectoryExists)
}

@Test func computeDeltaFromNil() {
    let monitor = ClaudeSessionMonitor()
    let stats = SessionStats(totalSessions: 3, totalPrompts: 10, totalToolUses: 5)
    let delta = monitor.computeDelta(from: nil, to: stats)
    #expect(delta.newSessions == 3)
    #expect(delta.newPrompts == 10)
    #expect(delta.newToolUses == 5)
    #expect(delta.hasActivity)
}

@Test func computeDeltaIncremental() {
    let monitor = ClaudeSessionMonitor()
    let old = SessionStats(totalSessions: 2, totalPrompts: 8, totalToolUses: 4)
    let new = SessionStats(totalSessions: 3, totalPrompts: 12, totalToolUses: 7)
    let delta = monitor.computeDelta(from: old, to: new)
    #expect(delta.newSessions == 1)
    #expect(delta.newPrompts == 4)
    #expect(delta.newToolUses == 3)
}

@Test func computeDeltaNoActivity() {
    let monitor = ClaudeSessionMonitor()
    let stats = SessionStats(totalSessions: 5, totalPrompts: 20, totalToolUses: 10)
    let delta = monitor.computeDelta(from: stats, to: stats)
    #expect(!delta.hasActivity)
    #expect(delta.newSessions == 0)
}

@Test func readStatsFromFile() throws {
    let dir = NSTemporaryDirectory() + "damagochi-test-\(UUID().uuidString)"
    try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true)
    defer { try? FileManager.default.removeItem(atPath: dir) }

    let stats = SessionStats(totalSessions: 5, totalPrompts: 42, totalToolUses: 18)
    let data = try JSONEncoder().encode(stats)
    let filePath = dir + "/.session-stats.json"
    try data.write(to: URL(fileURLWithPath: filePath))

    let monitor = ClaudeSessionMonitor(claudeDir: dir)
    let loaded = monitor.readStats()
    #expect(loaded != nil)
    #expect(loaded?.totalSessions == 5)
    #expect(loaded?.totalPrompts == 42)
    #expect(loaded?.totalToolUses == 18)
}

@Test func readStatsMissingFileReturnsNil() {
    let monitor = ClaudeSessionMonitor(claudeDir: "/tmp/nonexistent-\(UUID().uuidString)")
    #expect(monitor.readStats() == nil)
}

@Test func countSessionFiles() throws {
    let dir = NSTemporaryDirectory() + "damagochi-test-\(UUID().uuidString)"
    let sessionsDir = dir + "/sessions"
    try FileManager.default.createDirectory(atPath: sessionsDir, withIntermediateDirectories: true)
    defer { try? FileManager.default.removeItem(atPath: dir) }

    for i in 0..<3 {
        FileManager.default.createFile(atPath: sessionsDir + "/session-\(i).json", contents: Data())
    }

    let monitor = ClaudeSessionMonitor(claudeDir: dir)
    #expect(monitor.countSessionFiles() == 3)
}
