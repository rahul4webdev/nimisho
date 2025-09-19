#!/bin/sh

# ci_post_clone.sh - App Store Archive Build
set -e

echo "🔧 Setting up Flutter for App Store archive build"

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

# Configure Flutter for release builds
export PATH="$FLUTTER_HOME/bin:$PATH"
flutter config --enable-ios
flutter config --no-analytics

# Clean for production build
echo "🧹 Cleaning for production build..."
flutter clean
rm -rf ios/build/ 2>/dev/null || true
rm -rf build/ 2>/dev/null || true
rm -rf ios/Flutter/flutter_assets 2>/dev/null || true
rm -rf ios/.symlinks 2>/dev/null || true
rm -rf ios/Pods/ 2>/dev/null || true

# Set permissions
chmod -R 777 . 2>/dev/null || true

# Get dependencies
echo "📱 Getting Flutter dependencies..."
flutter pub get

# Build for RELEASE (App Store)
echo "🏗️  Building Flutter for App Store release..."
flutter build ios --release --no-codesign

# Verify release build
if [ -f "build/ios/Release-iphoneos/Runner.app/Info.plist" ]; then
    echo "✅ Flutter release build completed successfully"
else
    echo "❌ Flutter release build failed"
    exit 1
fi

# Install CocoaPods
echo "📦 Installing CocoaPods dependencies..."
cd ios
pod install --repo-update

echo "✅ App Store build setup completed successfully"