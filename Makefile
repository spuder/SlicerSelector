# Makefile for building an AppleScript app with a custom icon

# Variables
SCRIPT_NAME = SlicerSelector
SCRIPT_SRC = $(SCRIPT_NAME).applescript
APP_NAME = $(SCRIPT_NAME).app
ICON_FILE = ./img/SlicerSelector.icns
PREFIX ?= /Applications
INSTALL_DIR = $(PREFIX)
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
	cp -f $(ICON_FILE) $(APP_NAME)/Contents/Resources/SlicerSelector.icns; \
	mkdir -p $(APP_NAME)/Contents/Resources/images; \
	cp -f $(ICON_FILE) $(APP_NAME)/Contents/Resources/images/SlicerSelector.icns; \

# Modify Info.plist target
modify_plist:
	@echo "Modifying Info.plist to support file extensions"
	@/usr/libexec/PlistBuddy -c "Delete :CFBundleDocumentTypes" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile SlicerSelector.icns" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0 dict" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeExtensions array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeExtensions:0 string 3mf" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeExtensions:1 string 3MF" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeName string 3MF" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeRole string Viewer" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:LSIsAppleDefaultForType bool true" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:LSHandlerRank string Default" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:0:CFBundleTypeIconFile string images/SlicerSelector.icns" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1 dict" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeExtensions array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeExtensions:0 string stl" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeExtensions:1 string STL" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeName string STL" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:CFBundleTypeRole string Viewer" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:LSIsAppleDefaultForType bool true" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:1:LSHandlerRank string Default" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2 dict" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2:CFBundleTypeExtensions array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2:CFBundleTypeExtensions:0 string obj" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2:CFBundleTypeExtensions:1 string OBJ" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2:CFBundleTypeName string OBJ" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2:CFBundleTypeRole string Viewer" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2:LSIsAppleDefaultForType bool true" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2:LSHandlerRank string Default" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:2:CFBundleTypeIconFile string images/SlicerSelector.icns" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3 dict" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3:CFBundleTypeExtensions array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3:CFBundleTypeExtensions:0 string gcode" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3:CFBundleTypeExtensions:1 string GCODE" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3:CFBundleTypeName string GCODE" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3:CFBundleTypeRole string Viewer" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3:LSIsAppleDefaultForType bool true" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3:LSHandlerRank string Default" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:3:CFBundleTypeIconFile string images/SlicerSelector.icns" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4 dict" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4:CFBundleTypeExtensions array" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4:CFBundleTypeExtensions:0 string amf" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4:CFBundleTypeExtensions:1 string AMF" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4:CFBundleTypeName string AMF" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4:CFBundleTypeRole string Viewer" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4:LSIsAppleDefaultForType bool true" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4:LSHandlerRank string Default" $(INFO_PLIST)
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:4:CFBundleTypeIconFile string images/SlicerSelector.icns" $(INFO_PLIST)

	@echo "Removing unnecessary usage descriptions from Info.plist"
	@/usr/libexec/PlistBuddy -c "Delete :NSAppleEventsUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSAppleMusicUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSCalendarsUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSCameraUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSContactsUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSHomeKitUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSMicrophoneUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSPhotoLibraryUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSRemindersUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSSiriUsageDescription" $(INFO_PLIST) 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :NSSystemAdministrationUsageDescription" $(INFO_PLIST) 2>/dev/null || true

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
	@mkdir -p "$(INSTALL_DIR)"
	@if [ -d "$(INSTALL_DIR)/$(APP_NAME)" ]; then \
		rm -rf "$(INSTALL_DIR)/$(APP_NAME)"; \
	fi
	@cp -R $(APP_NAME) $(INSTALL_DIR)
	@echo "Installation complete"

# Clean target
clean:
	rm -rf $(APP_NAME)

.PHONY: all build modify_plist resign install clean
