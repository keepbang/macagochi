APP_NAME    = Damagochi
CLI_NAME    = damagochi
BUILD_DIR   = .build/apple/Products/Release
APP_BUNDLE  = $(BUILD_DIR)/$(APP_NAME).app
INSTALL_APP = /Applications/$(APP_NAME).app
INSTALL_CLI = /usr/local/bin/$(CLI_NAME)

DIST_DIR    = dist
DIST_ZIP    = $(DIST_DIR)/Damagochi.zip

.PHONY: build app install uninstall dist clean

build:
	swift build -c release --product DamagochiApp --arch arm64 --arch x86_64
	swift build -c release --product damagochi --arch arm64 --arch x86_64

app: build
	@mkdir -p "$(APP_BUNDLE)/Contents/MacOS" "$(APP_BUNDLE)/Contents/Resources"
	@cp "$(BUILD_DIR)/DamagochiApp" "$(APP_BUNDLE)/Contents/MacOS/$(APP_NAME)"
	@cp Resources/Info.plist "$(APP_BUNDLE)/Contents/Info.plist"
	@cp Resources/AppIcon.icns "$(APP_BUNDLE)/Contents/Resources/AppIcon.icns"
	@echo "Built: $(APP_BUNDLE)"

install: app
	@echo "Installing $(APP_NAME).app → /Applications"
	@rm -rf "$(INSTALL_APP)"
	@cp -r "$(APP_BUNDLE)" "$(INSTALL_APP)"
	@xattr -cr "$(INSTALL_APP)"
	@echo "Installing $(CLI_NAME) → $(INSTALL_CLI)"
	@cp "$(BUILD_DIR)/$(CLI_NAME)" "$(INSTALL_CLI)"
	@echo ""
	@echo "Done! Run: open /Applications/$(APP_NAME).app"
	@echo "Then run: $(CLI_NAME) hook install"

dist: app
	@rm -rf "$(DIST_DIR)" && mkdir -p "$(DIST_DIR)/Damagochi"
	@cp -r "$(APP_BUNDLE)" "$(DIST_DIR)/Damagochi/Damagochi.app"
	@cp "$(BUILD_DIR)/$(CLI_NAME)" "$(DIST_DIR)/Damagochi/damagochi"
	@cp install.sh "$(DIST_DIR)/Damagochi/install.sh"
	@chmod +x "$(DIST_DIR)/Damagochi/install.sh"
	@cd "$(DIST_DIR)" && zip -qr Damagochi.zip Damagochi/
	@rm -rf "$(DIST_DIR)/Damagochi"
	@echo "배포 파일 생성 완료: $(DIST_ZIP)"

uninstall:
	@rm -rf "$(INSTALL_APP)" && echo "Removed $(INSTALL_APP)" || true
	@rm -f "$(INSTALL_CLI)" && echo "Removed $(INSTALL_CLI)" || true

clean:
	swift package clean
