import Testing
@testable import DamagochiMonitor

@Test func monitorInitialization() {
    let monitor = ClaudeSessionMonitor(claudeDir: "/tmp/test-claude")
    #expect(monitor.sessionsPath == "/tmp/test-claude/sessions")
}
