#!/bin/sh

# ci_post_clone.sh
# This script runs after Xcode Cloud clones your repository

set -e  # Exit on any error

echo "🔧 Starting post-clone setup for Flutter iOS build"

# Navigate to iOS directory
cd $CI_WORKSPACE/ios

echo "📦 Installing CocoaPods dependencies..."
pod install --repo-update

echo "✅ Post-clone setup completed successfully"