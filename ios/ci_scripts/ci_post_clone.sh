#!/bin/sh

# ci_post_clone.sh
# This script runs after Xcode Cloud clones your repository

set -e  # Exit on any error

echo "🔧 Starting post-clone setup for Flutter iOS build"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Script directory: $SCRIPT_DIR"

# The script is in ios/ci_scripts/, so project root is two levels up
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
IOS_DIR="$(dirname "$SCRIPT_DIR")"

echo "📁 Project root: $PROJECT_ROOT"
echo "📁 iOS directory: $IOS_DIR"

# Navigate to project root first for Flutter commands
cd "$PROJECT_ROOT"
echo "📱 Current directory for Flutter: $(pwd)"

# Run Flutter pub get to generate necessary files
echo "📱 Running flutter pub get..."
flutter pub get

# Check if Generated.xcconfig was created
if [ -f "ios/Flutter/Generated.xcconfig" ]; then
    echo "✅ Generated.xcconfig created successfully"
else
    echo "⚠️  Generated.xcconfig not found, trying flutter build ios --config-only"
    flutter build ios --config-only
fi

# Navigate to iOS directory for CocoaPods
cd "$IOS_DIR"
echo "📦 Current directory for CocoaPods: $(pwd)"

# Install CocoaPods dependencies
echo "📦 Installing CocoaPods dependencies..."
pod install --repo-update

echo "✅ Post-clone setup completed successfully"