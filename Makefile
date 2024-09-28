# Makefile for building an AppleScript app with a custom icon

# Variables
SCRIPT_NAME = SlicerSelector
SCRIPT_SRC = $(SCRIPT_NAME).scpt
APP_NAME = $(SCRIPT_NAME).app
ICON_FILE = ./img/SlicerSelector.icns
INSTALL_DIR = /Applications
INFO_PLIST = $(APP_NAME)/Contents/Info.plist

# Default target
all: build modify_plist resign

# Build target
build:
	@if [ ! -f "$(SCRIPT_SRC)" ]; then \
		echo "Error: Script file $(SCRIPT_SRC) not found"; \
		exit 1; \
	fi
	echo "Building $(APP_NAME) with custom icon $(ICON_FILE)"; \
	osacompile -o $(APP_NAME) $(SCRIPT_SRC); \
	cp -f $(ICON_FILE) $(APP_NAME)/Contents/Resources/droplet.icns; \

# Modify Info.plist target
modify_plist:
	@echo "Modifying Info.plist to support .3mf and .stl files"
	@/usr/libexec/PlistBuddy -c "Delete :CFBundleDocumentTypes" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0 dict" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeExtensions array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeExtensions:0 string 3mf" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeName string 3D Manufacturing Format" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeRole string Editor" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:LSHandlerRank string Owner" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1 dict" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeExtensions array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeExtensions:0 string stl" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeName string STL 3D File" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeRole string Editor" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:LSHandlerRank string Owner" $(INFO_PLIST)

# Resign target
resign:
	@echo "Checking if app needs to be resigned..."
	@if ! codesign -v $(APP_NAME) 2>/dev/null; then \
		echo "Resigning the app..."; \
		codesign --force --deep --sign - $(APP_NAME); \
	else \
		echo "App signature is valid. No need to resign."; \
	fi

# Install target
install: all
	@echo "Installing $(APP_NAME) to $(INSTALL_DIR)"
	@if [ -d "$(INSTALL_DIR)/$(APP_NAME)" ]; then \
		rm -rf "$(INSTALL_DIR)/$(APP_NAME)"; \
	fi
	@cp -R $(APP_NAME) $(INSTALL_DIR)
	@echo "Installation complete"

# Clean target
clean:
	rm -rf $(APP_NAME)

.PHONY: all build modify_plist resign install clean