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

Claude Code의 Hook 시스템과 통합되어, 파일 저장, Git 커밋, 코딩 세션 등의 개발 활동을 감지합니다. 이러한 활동들이 쌓이면서 당신의 펫이 레벨업하고, 새로운 종으로 진화하며, 독특한 성격을 얻습니다.

### 핵심 특징

- 🎨 **픽셀 아트 펫** - 메뉴바에서 귀여운 도트 무늬 펫 감상
- 📈 **XP 기반 성장** - 코딩 활동으로 경험치 적립 및 레벨업
- 🧬 **진화 시스템** - 조건을 만족하면 새로운 종으로 진화
- 💝 **성격 시스템** - 상호작용으로 형성되는 고유의 성격
- 🎖️ **업적 시스템** - 각종 도전 과제 완료 및 수집
- 🛠️ **장비 시스템** - 드롭되는 장비 착용으로 펫 꾸미기
- 📊 **통계 & 추모관** - 키워본 펫들의 기록 관리
- 🤖 **Claude Code 연동** - Hook 자동 설치로 즉시 시작

## 🚀 설치

### Homebrew (권장)

```bash
brew tap keepbang/macagochi
brew install --cask keepbang/macagochi/macagochi
open /Applications/Damagochi.app
```

앱 실행 후 **온보딩 화면에서 Claude Code Hook이 자동으로 등록**됩니다.

### 수동 설치 (개발자용)

#### 요구사항

- macOS 14 이상
- Xcode 15 이상
- Swift 5.10 이상

#### 빌드 및 설치

```bash
# 저장소 클론
git clone https://github.com/keepbang/macagochi.git
cd macagochi

# 빌드 및 설치
make install

# 앱 실행
open /Applications/Damagochi.app
```

설치 완료 후 온보딩에서 Hook을 등록하면 Claude Code 연동이 시작됩니다.

### 업데이트

```bash
brew update && brew upgrade --cask macagochi
```

## 📖 사용 방법

### 기본 사용법

1. **앱 실행**: `/Applications/Damagochi.app` 더블클릭
2. **Hook 등록**: 온보딩 화면에서 "Hook 등록" 버튼 클릭
3. **코딩 시작**: Claude Code를 사용하면 자동으로 펫이 성장합니다

### 메뉴바 상호작용

- 🖱️ **클릭**: 펫 터치 (기분과 성격 영향)
- 🖱️ **우클릭**: 메뉴 열기 (피드, 설정 등)
- 📲 **알림**: 수중 및 배고픔 상태 알림 (설정에서 조정 가능)

### 탭별 기능

| 탭 | 설명 |
|---|---|
| 🐾 **펫** | 현재 펫의 상태, 레벨, 경험치 표시 |
| 🎒 **인벤토리** | 착용 가능한 장비 목록 및 착용/해제 |
| 🏆 **업적** | 달성한 업적과 진행 상황 |
| 📖 **추모관** | 지나간 펫들의 기록 |
| ⚙️ **설정** | 알림, Hook 상태, 초기화 등 |

## 🎮 게임 시스템

### 성장 시스템

펫은 다음 활동으로 경험치를 얻습니다:

- 📝 파일 저장: 5 XP
- 💾 Git 커밋: 20 XP
- 🔧 Claude Code 세션: 10 XP (분당)

레벨업에 필요한 경험치는 점진적으로 증가합니다.

### 진화 시스템

특정 조건을 만족하면 펫이 새로운 종으로 진화합니다:

- **초기 형태** → **중급 형태** (Lv 10 도달)
- **중급 형태** → **최종 형태** (Lv 20 도달 + 특정 성격)

### 성격 시스템

펫과의 상호작용이 쌓이면서 형성되는 고유의 성격:

- 🤗 **친절함**: 자주 터치할수록 증가
- 😎 **독립심**: 오래 방치할수록 증가
- 🎉 **활발함**: 커밋과 활동으로 증가
- 😴 **게으름**: 활동 부족으로 증가

### 장비 시스템

펫 레벨업 또는 업적 달성 시 장비가 드롭됩니다:

- 🎩 모자, 🎓 안경, 🎵 음표 등 다양한 아이템
- 최대 3개까지 동시 착용 가능
- 장비는 펫의 외형을 변경합니다

### 업적 시스템

다양한 도전 과제 달성:

- 🎉 사회적 나비 (100회 터치)
- 🚀 코딩 광인 (1000 XP 획득)
- 🎖️ 장비 수집가 (모든 장비 수집)
- 🌟 최종 진화 (모든 종 진화)

### 건강 & 관리

- ❤️ **체력**: 활동과 휴식으로 회복
- 😋 **포만도**: 시간 경과로 감소 (코딩으로 회복)
- 😊 **기분**: 터치와 활동으로 향상
- 💀 **사망**: 체력이 0이 되면 발생 (데이터는 추모관에 저장)

## 🛠️ 개발

### 프로젝트 구조

```
damagochi/
├── Sources/
│   ├── DamagochiCore/          # 게임 로직 & 데이터 모델
│   │   ├── Models/             # Pet, Species, Equipment, Achievement
│   │   ├── Engine/             # XP, Evolution, Health, Achievement
│   │   └── Events/             # 이벤트 처리
│   ├── DamagochiApp/           # macOS 메뉴바 앱
│   │   ├── Views/              # UI 컴포넌트
│   │   ├── PetViewModel.swift   # 상태 관리
│   │   └── AppDelegate.swift    # 앱 진입점
│   ├── DamagochiMonitor/       # Claude Code Hook 연동
│   │   ├── HookInstaller.swift  # Hook 자동 설치
│   │   └── FileSystemWatcher.swift
│   ├── DamagochiStorage/       # 데이터 저장
│   │   └── PetStore.swift
│   ├── DamagochiRenderer/      # 픽셀 아트 렌더링
│   │   └── SpriteSheet.swift
│   └── DamagochiCLI/           # CLI 도구
├── Tests/                      # 단위 및 통합 테스트
└── Resources/                  # 아이콘, Info.plist 등
```

### 빌드

```bash
# 전체 빌드 (Release)
make build

# 앱 번들 생성
make app

# 설치
make install

# 배포 ZIP 생성
make dist

# 정리
make clean
```

### 테스트

```bash
swift test
```

### 주요 모듈

#### DamagochiCore
게임의 핵심 로직을 담당합니다:
- `PetState`: 펫의 모든 상태 저장
- `XPEngine`: 레벨업 및 경험치 관리
- `EvolutionEngine`: 진화 판정 및 처리
- `HealthSystem`: 체력, 배고픔, 기분 관리
- `AchievementChecker`: 업적 판정

#### DamagochiMonitor
Claude Code Hook과의 상호작용:
- `HookInstaller`: Hook 자동 설치 및 관리
- `ClaudeSessionMonitor`: 개발 활동 모니터링
- `FileSystemWatcher`: 파일 변경 감시

#### DamagochiRenderer
픽셀 아트 스프라이트 렌더링:
- `SpriteSheet`: 종/진화 단계/장비별 프레임 생성
- 애니메이션 프레임 관리

### 컨벤션

- **명명**: camelCase (변수/함수), PascalCase (클래스/구조체)
- **테스트**: `*Tests.swift` 파일로 `swift test` 실행
- **커밋**: 한국어 또는 영어 (일관성 유지)
- **SwiftUI**: 최신 버전 사용, Preview 포함

## 🤝 기여

버그 리포트, 기능 제안, 코드 기여를 환영합니다!

### 기여 방법

1. Fork 저장소
2. Feature 브랜치 생성 (`git checkout -b feature/amazing-feature`)
3. 변경사항 커밋 (`git commit -m 'feat: 멋진 기능 추가'`)
4. 브랜치 Push (`git push origin feature/amazing-feature`)
5. Pull Request 생성

### 개발 환경 설정

```bash
# 저장소 클론
git clone https://github.com/keepbang/macagochi.git
cd macagochi

# 의존성 설치 (자동)
swift build

# Xcode에서 열기
xed .
```

### 코드 스타일

```bash
# Swift Lint 실행 (선택사항)
brew install swiftlint
swiftlint
```

## 📚 기술 스택

| 요소 | 기술 |
|-----|-----|
| **언어** | Swift 5.10+ |
| **플랫폼** | macOS 14+ |
| **UI 프레임워크** | SwiftUI |
| **빌드 시스템** | Swift Package Manager (SPM) |
| **데이터 저장** | FileManager + Codable |
| **통신** | IPC (Inter-Process Communication) |
| **Hook 시스템** | Claude Code Hook API |

## 📦 배포

### Homebrew Tap 배포

```bash
# 업데이트된 바이너리 생성
make dist

# Homebrew Tap 저장소에 업로드
# (https://github.com/keepbang/homebrew-macagochi)
```

### 직접 배포

```bash
# ZIP 파일 생성
make dist

# dist/Damagochi.zip 사용자에게 전달
```

## 🐛 문제 해결

### Hook이 등록되지 않음

```bash
# Hook 상태 확인
damagochi hook status

# Hook 수동 등록
damagochi hook install

# Hook 제거
damagochi hook uninstall
```

### 앱이 시작되지 않음

```bash
# 앱 재설치
make uninstall
make install

# 데이터 초기화 (주의!)
rm -rf ~/Library/Application\ Support/Damagochi
open /Applications/Damagochi.app
```

### 펫이 성장하지 않음

1. Hook 등록 상태 확인 (설정 탭)
2. Claude Code에서 파일 저장 또는 커밋 수행
3. 메뉴바 앱 재시작 후 확인

## 📋 라이선스

MIT License - [LICENSE](./LICENSE) 파일 참고

```
Copyright (c) 2026 chae-gibyung

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

## 🙏 감사의 말

- [Swift Argument Parser](https://github.com/apple/swift-argument-parser) - CLI 구현
- macOS SwiftUI 커뮤니티
- Claude Code 팀의 Hook API

## 📞 연락 & 피드백

- 🐛 **버그 리포트**: [Issues](https://github.com/keepbang/macagochi/issues)
- 💡 **기능 제안**: [Discussions](https://github.com/keepbang/macagochi/discussions)
- 📧 **이메일**: 저장소의 Issue 탭에서 문의

---

<div align="center">
  <p>
    <strong>Made with 💜 by keepbang</strong>
  </p>
  <p>
    <a href="https://github.com/keepbang/macagochi">GitHub</a> •
    <a href="https://github.com/keepbang/homebrew-macagochi">Homebrew Tap</a>
  </p>
</div>
