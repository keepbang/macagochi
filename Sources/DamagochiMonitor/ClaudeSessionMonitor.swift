import Foundation
import DamagochiCore

public struct SessionStats: Codable, Sendable {
    public var totalSessions: Int
    public var totalPrompts: Int
    public var totalToolUses: Int

    public init(totalSessions: Int = 0, totalPrompts: Int = 0, totalToolUses: Int = 0) {
        self.totalSessions = totalSessions
        self.totalPrompts = totalPrompts
        self.totalToolUses = totalToolUses
    }
}

public struct SessionDelta: Sendable {
    public var newSessions: Int
    public var newPrompts: Int
    public var newToolUses: Int

    public init(newSessions: Int = 0, newPrompts: Int = 0, newToolUses: Int = 0) {
        self.newSessions = newSessions
        self.newPrompts = newPrompts
        self.newToolUses = newToolUses
    }

    public var hasActivity: Bool {
        newSessions > 0 || newPrompts > 0 || newToolUses > 0
    }
}

public struct SessionSummary: Sendable {
    public var prompts: Int
    public var toolUses: Int
}

public final class ClaudeSessionMonitor: @unchecked Sendable {
    public typealias DeltaHandler = @Sendable (SessionDelta) -> Void
    public typealias SessionStartHandler = @Sendable () -> Void
    public typealias SessionEndHandler = @Sendable (SessionSummary) -> Void

    private let claudeDir: String
    private let onDelta: DeltaHandler?
    private let onSessionStart: SessionStartHandler?
    private let onSessionEnd: SessionEndHandler?

    private var statsWatcher: FileSystemWatcher?
    private var sessionsWatcher: FileSystemWatcher?
    private var lastStats: SessionStats?
    private var lastSessionCount: Int = 0
    private let lock = NSLock()
    private var inactivityWorkItem: DispatchWorkItem?
    private let timerQueue = DispatchQueue(label: "damagochi.session-inactivity")
    private var sessionPrompts: Int = 0
    private var sessionToolUses: Int = 0

    public init(
        claudeDir: String = NSHomeDirectory() + "/.claude",
        onDelta: DeltaHandler? = nil,
        onSessionStart: SessionStartHandler? = nil,
        onSessionEnd: SessionEndHandler? = nil
    ) {
        self.claudeDir = claudeDir
        self.onDelta = onDelta
        self.onSessionStart = onSessionStart
        self.onSessionEnd = onSessionEnd
    }

    public var sessionsPath: String { claudeDir + "/sessions" }
    public var statsFilePath: String { claudeDir + "/.session-stats.json" }

    public var claudeDirectoryExists: Bool {
        FileManager.default.fileExists(atPath: claudeDir)
    }

    public func readStats() -> SessionStats? {
        guard let data = FileManager.default.contents(atPath: statsFilePath) else { return nil }
        return try? JSONDecoder().decode(SessionStats.self, from: data)
    }

    public func countSessionFiles() -> Int {
        let fm = FileManager.default
        guard let entries = try? fm.contentsOfDirectory(atPath: sessionsPath) else { return 0 }
        return entries.count
    }

    public func computeDelta(from old: SessionStats?, to new: SessionStats) -> SessionDelta {
        guard let old else {
            return SessionDelta(
                newSessions: new.totalSessions,
                newPrompts: new.totalPrompts,
                newToolUses: new.totalToolUses
            )
        }
        return SessionDelta(
            newSessions: max(0, new.totalSessions - old.totalSessions),
            newPrompts: max(0, new.totalPrompts - old.totalPrompts),
            newToolUses: max(0, new.totalToolUses - old.totalToolUses)
        )
    }

    public func startMonitoring() {
        lock.lock()
        lastStats = readStats()
        lastSessionCount = countSessionFiles()
        lock.unlock()

        statsWatcher = FileSystemWatcher(path: statsFilePath) { [weak self] event in
            guard let self, event == .write else { return }
            self.handleStatsChange()
        }

        sessionsWatcher = FileSystemWatcher(path: sessionsPath) { [weak self] event in
            guard let self, event == .write else { return }
            self.handleSessionsDirChange()
        }

        _ = statsWatcher?.start()
        _ = sessionsWatcher?.start()
    }

    public func stopMonitoring() {
        statsWatcher?.stop()
        sessionsWatcher?.stop()
        statsWatcher = nil
        sessionsWatcher = nil
        inactivityWorkItem?.cancel()
        inactivityWorkItem = nil
    }

    private func handleStatsChange() {
        guard let newStats = readStats() else { return }
        lock.lock()
        let old = lastStats
        lastStats = newStats
        lock.unlock()

        let delta = computeDelta(from: old, to: newStats)
        if delta.hasActivity {
            lock.lock()
            sessionPrompts += delta.newPrompts
            sessionToolUses += delta.newToolUses
            lock.unlock()
            onDelta?(delta)
            scheduleSessionEndCheck()
        }
    }

    private func scheduleSessionEndCheck() {
        inactivityWorkItem?.cancel()
        let item = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.lock.lock()
            let summary = SessionSummary(prompts: self.sessionPrompts, toolUses: self.sessionToolUses)
            self.sessionPrompts = 0
            self.sessionToolUses = 0
            self.lock.unlock()
            self.onSessionEnd?(summary)
        }
        inactivityWorkItem = item
        timerQueue.asyncAfter(deadline: .now() + 120, execute: item)
    }

    private func handleSessionsDirChange() {
        let newCount = countSessionFiles()
        lock.lock()
        let oldCount = lastSessionCount
        lastSessionCount = newCount
        lock.unlock()

        if newCount > oldCount {
            onSessionStart?()
        }
    }
}
