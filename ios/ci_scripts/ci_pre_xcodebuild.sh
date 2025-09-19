#!/bin/sh

# ci_pre_xcodebuild.sh
set -e

echo "🔧 Pre-build diagnostics and setup"

# Function to log with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "🔍 Pre-build Environment Check:"
log "Current directory: $(pwd)"
log "CI_WORKSPACE: ${CI_WORKSPACE:-'not set'}"
log "CI_DERIVED_DATA_PATH: ${CI_DERIVED_DATA_PATH:-'not set'}"
log "CONFIGURATION: ${CONFIGURATION:-'not set'}"

# Get the correct project root directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
IOS_DIR="$(dirname "$SCRIPT_DIR")"

log "Script directory: $SCRIPT_DIR"
log "Project root: $PROJECT_ROOT"
log "iOS directory: $IOS_DIR"

# Navigate to project root
cd "$PROJECT_ROOT"
log "Changed to project root: $(pwd)"

# Add Flutter to PATH
export PATH="$HOME/flutter/bin:$PATH"

log "🔍 Flutter status:"
flutter --version

# Check iOS build configuration
log "📋 iOS Build Configuration:"
if [ -f "ios/Flutter/Generated.xcconfig" ]; then
    log "✅ Generated.xcconfig exists"
    cat ios/Flutter/Generated.xcconfig
else
    log "❌ Generated.xcconfig missing! Regenerating..."
    flutter build ios --config-only --no-codesign
fi

# Set comprehensive permissions
log "🔧 Setting build permissions..."
chmod -R 777 ios/ 2>/dev/null || true
chmod -R 777 build/ 2>/dev/null || true

# Ensure derived data directory exists and is writable
if [ -n "$CI_DERIVED_DATA_PATH" ]; then
    log "🔧 Setting up derived data path: $CI_DERIVED_DATA_PATH"
    mkdir -p "$CI_DERIVED_DATA_PATH" 2>/dev/null || true
    chmod -R 777 "$CI_DERIVED_DATA_PATH" 2>/dev/null || true
fi

# Check for common build issues
log "🔍 Checking for potential issues:"

# Check if Flutter is properly configured
if [ ! -f "ios/Flutter/AppFrameworkInfo.plist" ]; then
    log "⚠️  AppFrameworkInfo.plist missing, regenerating Flutter config..."
    flutter build ios --config-only --no-codesign
fi

# Check Podfile.lock exists
if [ -f "ios/Podfile.lock" ]; then
    log "✅ Podfile.lock exists"
else
    log "❌ Podfile.lock missing! Reinstalling pods..."
    cd "$IOS_DIR"
    pod install
    cd "$PROJECT_ROOT"
fi

# Final directory structure check
log "📋 Final directory structure:"
log "Contents of project root:"
ls -la
log "Contents of ios directory:"
ls -la ios/

log "✅ Pre-build setup completed"