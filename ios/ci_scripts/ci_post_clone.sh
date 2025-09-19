#!/bin/sh

# ci_post_clone.sh
set -e

echo "🔧 Starting post-clone setup for Flutter iOS build"

# Navigate to project root
cd "$(dirname "$(dirname "$(dirname "$0")")")"
echo "📁 Project root: $(pwd)"

# Install Flutter 3.32.8
echo "📱 Setting up Flutter 3.32.8..."
FLUTTER_VERSION="3.32.8"
FLUTTER_HOME="$HOME/flutter"

if [ ! -d "$FLUTTER_HOME" ]; then
    echo "📥 Downloading Flutter $FLUTTER_VERSION..."
    curl -o flutter.zip "https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_$FLUTTER_VERSION-stable.zip"
    unzip -q flutter.zip -d "$HOME"
    rm flutter.zip
fi

# Add Flutter to PATH and configure
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter config --enable-ios

# Clean everything first
echo "🧹 Cleaning Flutter cache and build directories..."
flutter clean
rm -rf ios/build/
rm -rf build/
rm -rf ios/Flutter/flutter_assets
rm -rf ios/.symlinks
rm -rf ios/Pods/

# Create and set permissions for necessary directories
echo "🔧 Setting up build directories with proper permissions..."
mkdir -p build/ios
mkdir -p ios/build
mkdir -p ios/Flutter

# Set broader permissions to ensure Flutter can write
chmod -R 777 . 2>/dev/null || true
chmod -R 777 build/ 2>/dev/null || true
chmod -R 777 ios/build/ 2>/dev/null || true
chmod -R 777 ios/Flutter/ 2>/dev/null || true

# Also ensure the Flutter installation has proper permissions
chmod -R 755 "$FLUTTER_HOME" 2>/dev/null || true

# Get dependencies
echo "📱 Getting Flutter dependencies..."
flutter pub get

# Generate iOS configuration with specific build settings
echo "🔧 Generating iOS configuration..."
flutter build ios --config-only --no-codesign

# Ensure generated files have proper permissions
chmod -R 777 ios/Flutter/ 2>/dev/null || true
chmod -R 777 build/ 2>/dev/null || true

# Install CocoaPods dependencies
echo "📦 Installing CocoaPods dependencies..."
cd ios
pod install --repo-update

echo "✅ Setup completed successfully"