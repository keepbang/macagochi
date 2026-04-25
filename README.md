# 🐣 Damagochi

> Claude Code를 사용할 때마다 성장하는 macOS 메뉴바 다마고치 앱

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Swift 5.10+](https://img.shields.io/badge/Swift-5.10+-orange.svg)](https://www.swift.org)
[![macOS 14+](https://img.shields.io/badge/macOS-14%2B-blue.svg)](https://www.apple.com/kr/macos)

<div align="center">
  <img src="./Resources/screenshot.png" alt="Damagochi 메뉴바 예시" width="400">
</div>

## 🎮 소개

**Damagochi**는 당신의 코딩 활동을 추적하고 펫을 키우는 macOS 메뉴바 애플리케이션입니다.

Claude Code의 Hook 시스템과 통합되어, 프롬프트 입력, 툴 사용, 세션 시작 등의 개발 활동을 감지합니다. 이러한 활동들이 쌓이면서 당신의 펫이 부화하고, 레벨업하며, MBTI 기반의 고유한 성격을 형성합니다.

### 핵심 특징

- 🎨 **픽셀 아트 펫** - 메뉴바에서 귀여운 도트 무늬 펫 감상
- 📈 **XP 기반 성장** - 코딩 활동으로 경험치 적립 및 레벨업
- 🧬 **20종 캐릭터** - MBTI 그룹과 희귀도 기반 부화 시스템
- 🎭 **MBTI 성격 시스템** - 코딩 패턴으로 형성되는 고유 성격
- 🔥 **스트릭 시스템** - 연속 코딩으로 XP 배율 보너스
- 🐛 **버그 잡기 미니게임** - 랜덤 등장 버그 클릭으로 XP 획득
- 🎖️ **업적 시스템** - 각종 도전 과제 완료 및 수집
- 🛠️ **장비 시스템** - 레벨업 드롭 장비로 펫 꾸미기
- 📊 **통계 & 추모관** - 키워본 펫들의 기록 관리
- 🤖 **Claude Code 연동** - Hook 자동 설치로 즉시 시작

## 🚀 설치

### Homebrew (권장)

```bash
brew tap keepbang/damagochi
brew install --cask keepbang/damagochi/damagochi
open /Applications/Damagochi.app
```

앱 실행 후 **온보딩 화면에서 Claude Code Hook이 자동으로 등록**됩니다.

### 업데이트

```bash
brew update && brew upgrade --cask damagochi
```

### 수동 설치 (개발자용)

요구사항: macOS 14+, Xcode 15+

```bash
git clone https://github.com/keepbang/damagochi.git
cd damagochi
make install
open /Applications/Damagochi.app
```

### 앱 삭제

```bash
brew uninstall --cask damagochi
brew untap keepbang/damagochi
```

또는 수동 삭제: `/Applications/Damagochi.app` 삭제 후 설정 앱 내 **"모든 데이터 초기화"** 버튼 사용

## 📖 사용 방법

1. **앱 실행**: `/Applications/Damagochi.app` 더블클릭
2. **Hook 등록**: 온보딩 화면에서 자동 처리
3. **코딩 시작**: Claude Code를 사용하면 자동으로 펫이 성장합니다

### 메뉴바 상호작용

- 🖱️ **클릭**: 팝오버 열기/닫기
- 🔴 **빨간 점**: 잡을 수 있는 버그가 있음을 알림

### 탭별 기능

| 탭 | 설명 |
|---|---|
| 🐾 **펫** | 현재 펫의 상태, 레벨, 경험치, 스트릭 표시 |
| 🎒 **인벤토리** | 착용 가능한 장비 목록 및 착용/해제 |
| 🏆 **업적** | 달성한 업적과 진행 상황 |
| 📖 **추모관** | 지나간 펫들의 기록 |
| ⚙️ **설정** | 알림, Hook 상태, 방생, 초기화 등 |

## 🎮 게임 시스템

### 성장 시스템

알 단계에서 총 XP 100 달성 시 부화합니다. 부화 후에는 레벨업으로 성장합니다.

| 활동 | XP |
|------|-----|
| 프롬프트 입력 | 10 XP |
| 툴 사용 (Read, Edit 등) | 5 XP |
| 세션 시작 | 15 XP |
| 버그 잡기 | 15 ~ 300 XP |

### 스트릭 보너스

매일 Claude Code를 사용하면 스트릭이 유지되며 XP 배율이 증가합니다.

| 연속일 | XP 배율 | 마일스톤 보상 |
|--------|---------|-------------|
| 1~2일 | ×1.0 | - |
| 3~6일 | ×1.5 | - |
| 7~13일 | ×2.0 | 레어 장비 |
| 14~29일 | ×3.0 | - |
| 30일+ | ×5.0 | 레전더리 장비 |

### 캐릭터 & 희귀도

코딩 패턴에 따라 MBTI 그룹이 결정되고, 그룹 내에서 희귀도 기반으로 캐릭터가 결정됩니다.

| 희귀도 | 확률 | 연출 |
|--------|------|------|
| ⬜ 커먼 | 60% | 기본 |
| 🔵 레어 | 25% | 파란 글로우 |
| 🟡 레전더리 | 12% | 금색 글로우 |
| 🌈 미식 | 3% | 무지개 |

**MBTI 그룹별 캐릭터:**

| 그룹 | 커먼 | 레어 | 레전더리 | 미식 |
|------|------|------|---------|------|
| NT | 올빼미, 늑대 | 문어 | 드래곤 | 로봇 |
| NF | 나비, 구름 | 해파리, 여우 | 버섯 | - |
| SJ | 거북이, 팽귄 | 돌, 선인장 | 파리지옥 | - |
| SP | 고양이, 강아지 | 불꽃, 박쥐 | - | 달토끼 |

### 성장 단계

| 단계 | 조건 |
|------|------|
| Stage 1 (아기) | Lv 1 ~ 10 |
| Stage 2 (성장) | Lv 11 ~ 25 |
| Stage 3 (완전체) | Lv 26+ |

### 버그 잡기 미니게임

3~10분 랜덤 간격으로 버그가 등장합니다. 팝오버를 열어 클릭하면 XP 획득!

| 버그 | 확률 | XP | 제한 시간 |
|------|------|----|--------|
| 🐛 일반 | 70% | +15 | 30초 |
| 🔵 희귀 | 20% | +40 | 30초 |
| ⭐ 황금 | 9% | +100 | 30초 |
| 🌈 레인보우 | 1% | +300 | 15초 |

### 건강 & 관리

- ❤️ **체력**: 활동으로 회복, 방치 시 감소
- 😋 **배고픔**: Claude Code 사용 시 증가
- 😊 **기분**: 버그 잡기, 활발한 활동으로 상승
- 💀 **사망**: 14 영업일 이상 비활동 시 발생 (기록은 추모관에 저장)
- 🕊️ **방생**: 설정 탭에서 언제든지 펫을 보내고 새 알 시작 가능

## 🔧 초기화 / 문제 해결

앱 내 **설정 → 모든 데이터 초기화** 버튼으로 처음 상태로 되돌릴 수 있습니다.

Hook이 작동하지 않는 경우, 설정 탭에서 **Hook 제거 후 재설치**를 시도하세요.

## 📋 라이선스

MIT License - [LICENSE](./LICENSE) 파일 참고

## 🙏 감사의 말

- [Swift Argument Parser](https://github.com/apple/swift-argument-parser) - CLI 구현
- Claude Code 팀의 Hook API

---

<div align="center">
  <p><strong>Made with 💜 by keepbang</strong></p>
  <p>
    <a href="https://github.com/keepbang/damagochi">GitHub</a> •
    <a href="https://github.com/keepbang/homebrew-damagochi">Homebrew Tap</a> •
    <a href="https://github.com/keepbang/damagochi/issues">Issues</a>
  </p>
</div>
