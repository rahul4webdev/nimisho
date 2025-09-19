#!/bin/sh

# ci_pre_xcodebuild.sh - Pre-archive setup
set -e

echo "🔧 Pre-archive setup for App Store build"

# Navigate to project root
cd "$(dirname "$(dirname "$(dirname "$0")")")"

# Add Flutter to PATH
export PATH="$HOME/flutter/bin:$PATH"

# Set comprehensive permissions for archive build
echo "🔧 Setting permissions for archive build..."
chmod -R 777 /Volumes/workspace/ 2>/dev/null || true

# Pre-create archive-specific directories with proper permissions
mkdir -p "/Volumes/workspace/DerivedData/Build/Intermediates.noindex/ArchiveIntermediates/Runner/BuildProductsPath/Release-iphoneos/" 2>/dev/null || true
chmod -R 777 "/Volumes/workspace/DerivedData/" 2>/dev/null || true

# Pre-create the problematic .last_build_id file for archive
touch "/Volumes/workspace/DerivedData/Build/Intermediates.noindex/ArchiveIntermediates/Runner/BuildProductsPath/Release-iphoneos/.last_build_id" 2>/dev/null || true
chmod 777 "/Volumes/workspace/DerivedData/Build/Intermediates.noindex/ArchiveIntermediates/Runner/BuildProductsPath/Release-iphoneos/.last_build_id" 2>/dev/null || true

# Ensure Flutter build products have proper permissions
chmod -R 777 build/ 2>/dev/null || true
chmod -R 777 ios/ 2>/dev/null || true

echo "✅ Pre-archive setup completed"