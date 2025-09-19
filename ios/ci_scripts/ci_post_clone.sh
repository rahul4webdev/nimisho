#!/bin/sh

# ci_post_clone.sh
# This script runs after Xcode Cloud clones your repository

set -e  # Exit on any error

echo "🔧 Starting post-clone setup for Flutter iOS build"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Script directory: $SCRIPT_DIR"

# The script is in ios/ci_scripts/, so ios directory is the parent
IOS_DIR="$(dirname "$SCRIPT_DIR")"
echo "iOS directory: $IOS_DIR"

# Navigate to iOS directory
cd "$IOS_DIR"

echo "📦 Current directory: $(pwd)"
echo "📦 Contents:"
ls -la

echo "📦 Installing CocoaPods dependencies..."
pod install --repo-update

echo "✅ Post-clone setup completed successfully"