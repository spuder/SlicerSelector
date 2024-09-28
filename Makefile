# Makefile for building an AppleScript app with a custom icon

# Variables
SCRIPT_NAME = SlicerSelector
SCRIPT_SRC = $(SCRIPT_NAME).scpt
APP_NAME = $(SCRIPT_NAME).app
ICON_FILE = ./img/SlicerSelector.icns
INSTALL_DIR = /Applications

# Default target
all: build

# Build target
build:
	@if [ ! -f "$(SCRIPT_SRC)" ]; then \
		echo "Error: Script file $(SCRIPT_SRC) not found"; \
		exit 1; \
	fi
	echo "Building $(APP_NAME) with custom icon $(ICON_FILE)"; \
	osacompile -o $(APP_NAME) $(SCRIPT_SRC); \
	cp -f $(ICON_FILE) $(APP_NAME)/Contents/Resources/droplet.icns; \

# Install target
install: build
	@echo "Installing $(APP_NAME) to $(INSTALL_DIR)"
	@if [ -d "$(INSTALL_DIR)/$(APP_NAME)" ]; then \
		rm -rf "$(INSTALL_DIR)/$(APP_NAME)"; \
	fi
	@cp -R $(APP_NAME) $(INSTALL_DIR)
	@echo "Installation complete"

# Clean target
clean:
	rm -rf $(APP_NAME)

.PHONY: all build install clean