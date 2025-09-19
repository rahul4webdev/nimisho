#!/bin/sh

# ci_pre_xcodebuild.sh
# Runs right before xcodebuild

echo "🔧 Setting up permissions before Xcode build..."

# Ensure all necessary directories exist and have proper permissions
mkdir -p "$CI_DERIVED_DATA_PATH" 2>/dev/null || true
chmod -R 777 "$CI_DERIVED_DATA_PATH" 2>/dev/null || true

# Set permissions on the workspace directory
chmod -R 777 "$CI_WORKSPACE" 2>/dev/null || true

echo "✅ Pre-build setup completed"