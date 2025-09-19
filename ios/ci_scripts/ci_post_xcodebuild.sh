#!/bin/sh

# ci_post_xcodebuild.sh
set -e

echo "🔧 Post-build cleanup"

# Clean up any permission issues
chmod -R 777 /Volumes/workspace/DerivedData/ 2>/dev/null || true

echo "✅ Post-build cleanup completed"