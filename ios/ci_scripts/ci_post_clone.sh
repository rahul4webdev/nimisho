#!/bin/sh

# ci_post_clone.sh
set -e

echo "🔧 Starting post-clone setup for Flutter iOS build"

# Function to log with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Navigate to project root
cd "$(dirname "$(dirname "$(dirname "$0")")")"
log "📁 Project root: $(pwd)"

# Show environment info
log "🔍 Environment Information:"
log "User: $(whoami)"
log "Xcode version: $(xcodebuild -version || echo 'xcodebuild not found')"
log "Available disk space: $(df -h . | tail -1)"

# Install Flutter 3.32.8
log "📱 Setting up Flutter 3.32.8..."
FLUTTER_VERSION="3.32.8"
FLUTTER_HOME="$HOME/flutter"

if [ ! -d "$FLUTTER_HOME" ]; then
    log "📥 Downloading Flutter $FLUTTER_VERSION..."
    curl -o flutter.zip "https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_$FLUTTER_VERSION-stable.zip"
    unzip -q flutter.zip -d "$HOME"
    rm flutter.zip
    log "✅ Flutter downloaded and extracted"
else
    log "✅ Flutter already exists at $FLUTTER_HOME"
fi

# Add Flutter to PATH and configure
export PATH="$FLUTTER_HOME/bin:$PATH"
log "🔧 Configuring Flutter..."
flutter config --enable-ios

# Show Flutter info
log "🔍 Flutter Information:"
flutter --version
flutter doctor -v

# Clean everything thoroughly
log "🧹 Cleaning all build artifacts..."
flutter clean
rm -rf ios/build/ 2>/dev/null || true
rm -rf build/ 2>/dev/null || true
rm -rf ios/Flutter/flutter_assets 2>/dev/null || true
rm -rf ios/.symlinks 2>/dev/null || true
rm -rf ios/Pods/ 2>/dev/null || true
rm -rf ios/Podfile.lock 2>/dev/null || true

# Set up directories with proper permissions
log "🔧 Setting up build directories..."
mkdir -p build/ios
mkdir -p ios/build
mkdir -p ios/Flutter

# Set permissions
chmod -R 755 . 2>/dev/null || true
chmod -R 777 build/ 2>/dev/null || true
chmod -R 777 ios/build/ 2>/dev/null || true
chmod -R 777 ios/Flutter/ 2>/dev/null || true

# Get Flutter dependencies
log "📱 Getting Flutter dependencies..."
flutter pub get

# Check pubspec.yaml
log "📋 Checking pubspec.yaml dependencies:"
head -20 pubspec.yaml

# Generate iOS configuration
log "🔧 Generating iOS configuration..."
flutter build ios --config-only --no-codesign

# Verify generated files
log "✅ Checking generated files:"
if [ -f "ios/Flutter/Generated.xcconfig" ]; then
    log "✅ Generated.xcconfig exists"
    log "Contents of Generated.xcconfig:"
    cat ios/Flutter/Generated.xcconfig
else
    log "❌ Generated.xcconfig missing!"
    exit 1
fi

# Set final permissions on generated files
chmod -R 777 ios/Flutter/ 2>/dev/null || true

# Install CocoaPods
log "📦 Installing CocoaPods dependencies..."
cd ios

# Show Podfile content
log "📋 Podfile contents:"
cat Podfile

# Install pods with verbose output
pod install --repo-update --verbose

# Check the workspace
log "📋 Checking workspace structure:"
ls -la Runner.xcworkspace/

log "✅ Post-clone setup completed successfully"

# Final directory permissions
cd ..
chmod -R 777 ios/ 2>/dev/null || true
chmod -R 777 build/ 2>/dev/null || true

log "🔧 Final permission setup completed"