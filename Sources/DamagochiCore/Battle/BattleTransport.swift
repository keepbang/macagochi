import Foundation
import CryptoKit

// MARK: - Network Messages

public enum BattleMessage: Codable, Sendable {
    /// 연결 후 첫 핸드셰이크: 내 배틀 프로필 전송
    case profile(BattleProfile)
    /// 매 턴 스킬 선택 커밋 (commit-reveal: 해시 먼저)
    case skillCommit(hash: String, turn: Int)
    /// 커밋 확인 후 스킬 공개
    case skillReveal(skillId: String, nonce: String, turn: Int)
    /// 배틀 종료 확인
    case battleEnd(result: BattleResult)
    /// 항복
    case forfeit
}

// MARK: - Transport Events

public enum BattleTransportEvent: Sendable {
    case peerFound(peerId: String, peerName: String)
    case peerLost(peerId: String)
    case connected(peerId: String)
    case disconnected(peerId: String)
    case messageReceived(BattleMessage)
    case error(Error)
}

// MARK: - Transport Protocol

/// 배틀 통신 레이어 추상화.
/// Phase 1: LocalNetworkTransport (MultipeerConnectivity)
/// Phase 2: SupabaseTransport (클라우드)
public protocol BattleTransport: AnyObject, Sendable {
    /// 상대 탐색 시작
    func startBrowsing()
    /// 탐색 중지
    func stopBrowsing()
    /// 특정 피어에 연결 요청
    func connect(to peerId: String) async throws
    /// 연결 해제
    func disconnect()
    /// 메시지 전송
    func send(_ message: BattleMessage) throws
    /// 이벤트 스트림 (AsyncStream)
    var events: AsyncStream<BattleTransportEvent> { get }
}

// MARK: - Commit-Reveal Helper

public enum CommitReveal {
    /// 스킬 ID + 랜덤 nonce → SHA256 해시 (치팅 방지)
    public static func commit(skillId: String, nonce: String) -> String {
        let input = "\(skillId):\(nonce)"
        let hash = SHA256.hash(data: Data(input.utf8))
        return hash.map { String(format: "%02x", $0) }.joined()
    }

    public static func makeNonce() -> String {
        UUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
}

// MARK: - Turn Timeout

public enum BattleTimeout {
    /// 스킬 선택 제한 시간 (초)
    public static let skillSelectSeconds: TimeInterval = 30
    /// 타임아웃 시 자동 선택: 첫 번째 공격 스킬
    public static func defaultSkillId(for group: MbtiGroup) -> String {
        BattleSkill.skills(for: group).first(where: { $0.isAttack })?.id
            ?? BattleSkill.skills(for: group)[0].id
    }
}
