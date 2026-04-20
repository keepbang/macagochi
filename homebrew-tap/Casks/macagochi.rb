cask "macagochi" do
  version "0.1.0"
  sha256 "d6384e8790cd9f0a356112826f0fd46f6bc2d26f7719415443e190ba52c8d4d1"

  url "https://github.com/keepbang/macagochi/releases/download/v#{version}/Damagochi.zip"
  name "Macagochi"
  desc "Claude Code 활동으로 성장하는 다마고치 메뉴바 앱"
  homepage "https://github.com/keepbang/macagochi"

  quarantine false

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
end
