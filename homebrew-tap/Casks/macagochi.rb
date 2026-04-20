cask "macagochi" do
  version "0.1.0"
  sha256 "d6384e8790cd9f0a356112826f0fd46f6bc2d26f7719415443e190ba52c8d4d1"

  url "https://github.com/keepbang/macagochi/releases/download/v#{version}/Damagochi.zip"
  name "Macagochi"
  desc "Claude Code 활동으로 성장하는 다마고치 메뉴바 앱"
  homepage "https://github.com/keepbang/macagochi"

  app "Damagochi/Damagochi.app"
  binary "Damagochi/damagochi"

  postflight do
    system_command "#{HOMEBREW_PREFIX}/bin/damagochi",
                   args: ["hook", "install"],
                   sudo: false
  end

  uninstall quit:   "com.damagochi.app",
            delete: "/usr/local/bin/damagochi"

  zap trash: [
    "~/Library/Application Support/Damagochi",
    "~/Library/Preferences/com.damagochi.app.plist",
  ]

  caveats <<~EOS
    앱이 서명되지 않아 Gatekeeper가 차단할 수 있습니다.
    아래 명령어로 설치하면 경고 없이 실행됩니다:

      brew install --cask --no-quarantine keepbang/macagochi/macagochi

    이미 설치했다면:
      xattr -cr /Applications/Damagochi.app
  EOS
end
