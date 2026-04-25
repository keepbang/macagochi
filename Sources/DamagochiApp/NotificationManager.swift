import Foundation
import UserNotifications

final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

    private let center = UNUserNotificationCenter.current()

    private override init() {
        super.init()
        center.delegate = self
    }

    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func send(
        title: String,
        body: String,
        categoryId: String = "damagochi",
        delay: TimeInterval = 0.1
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.categoryIdentifier = categoryId

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        center.add(request)
    }

    func sendLevelUp(level: Int) {
        send(title: "레벨 업!", body: "레벨 \(level)에 도달했습니다!")
    }

    func sendHatched(speciesName: String) {
        send(title: "부화 완료!", body: "\(speciesName)(이)가 알에서 깨어났습니다!")
    }

    func sendEquipmentDrop(name: String) {
        send(title: "장비 획득!", body: "\(name) 아이템을 획득했습니다!")
    }

    func sendAchievement(name: String) {
        send(title: "업적 달성!", body: "\(name) 업적을 해금했습니다!")
    }

    func sendHungerWarning(hunger: Int) {
        send(title: "배고픔 경고", body: "펫의 배고픔이 \(hunger)%입니다. 코딩을 해주세요!")
    }

    func sendDeathRisk(days: Int) {
        send(title: "사망 위험!", body: "\(days)일째 활동이 없습니다. 펫이 위험합니다!")
    }

    func sendDeath() {
        send(title: "펫이 죽었습니다...", body: "14일간 활동이 없어 펫이 사망했습니다. 새로운 알로 다시 시작할 수 있습니다.")
    }

    func sendStreakWarning(streakDays: Int) {
        send(title: "스트릭 위기! 🔥",
             body: "오늘 아직 코딩 안 했어요! \(streakDays)일 스트릭이 끊길 것 같아요 😢")
    }

    func sendStreakMilestone(days: Int) {
        send(title: "스트릭 달성! 🎉", body: "\(days)일 연속 코딩 달성! 특별 장비를 획득했습니다!")
    }

    func sendBugSpawned(bugType: String, emoji: String) {
        send(title: "버그가 나타났어요! \(emoji)",
             body: "\(bugType) 버그를 잡으러 가세요! 빨리 잡지 않으면 도망가요 🏃",
             categoryId: "bug_spawn")
    }

    func scheduleStreakWarning(streakDays: Int) {
        center.removePendingNotificationRequests(withIdentifiers: ["streak-warning"])
        guard streakDays > 0 else { return }

        var components = DateComponents()
        components.hour = 21
        components.minute = 0

        let content = UNMutableNotificationContent()
        content.title = "스트릭 위기! 🔥"
        content.body = "오늘 아직 코딩 안 했어요! \(streakDays)일 스트릭이 끊길 것 같아요 😢"
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(
            identifier: "streak-warning",
            content: content,
            trigger: trigger
        )
        center.add(request)
    }

    // MARK: - UNUserNotificationCenterDelegate

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
