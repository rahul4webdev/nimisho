#!/bin/sh

# ci_post_clone.sh
# This script runs after Xcode Cloud clones your repository

set -e  # Exit on any error

echo "🔧 Starting post-clone setup for Flutter iOS build"

# Get directories
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
IOS_DIR="$(dirname "$SCRIPT_DIR")"

echo "📁 Project root: $PROJECT_ROOT"
echo "📁 iOS directory: $IOS_DIR"

# Navigate to project root
cd "$PROJECT_ROOT"

# Install Flutter 3.32.8
echo "📱 Installing Flutter 3.32.8..."
FLUTTER_VERSION="3.32.8"
FLUTTER_HOME="$HOME/flutter"

if [ ! -d "$FLUTTER_HOME" ]; then
    echo "📥 Downloading Flutter $FLUTTER_VERSION..."
    curl -o flutter.zip "https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_$FLUTTER_VERSION-stable.zip"
    unzip -q flutter.zip -d "$HOME"
    rm flutter.zip
else
    echo "✅ Flutter already exists at $FLUTTER_HOME"
fi

# Add Flutter to PATH
export PATH="$FLUTTER_HOME/bin:$PATH"

# Verify Flutter installation
echo "🔍 Flutter version:"
flutter --version

# Configure Flutter for iOS
flutter config --enable-ios

# Run flutter doctor to check setup
echo "🏥 Running flutter doctor..."
flutter doctor

# Clean and get Flutter dependencies
echo "📱 Running flutter clean and pub get..."
flutter clean
flutter pub get

# Generate iOS build configuration
echo "🔧 Generating iOS build configuration..."
flutter build ios --config-only --no-codesign

# Verify the Generated.xcconfig exists
if [ ! -f "ios/Flutter/Generated.xcconfig" ]; then
    echo "❌ Failed to generate Generated.xcconfig"
    echo "📁 Contents of ios/Flutter/:"
    ls -la ios/Flutter/
    exit 1
else
    echo "✅ Generated.xcconfig created successfully"
fi

# Navigate to iOS directory for CocoaPods
cd "$IOS_DIR"
echo "📦 Current directory for CocoaPods: $(pwd)"

# Install CocoaPods dependencies
echo "📦 Installing CocoaPods dependencies..."
pod install --repo-update

echo "✅ Post-clone setup completed successfully"