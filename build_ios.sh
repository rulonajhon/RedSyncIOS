#!/bin/bash

# RedSync iOS Build Script
# This script builds the Flutter app for iOS with proper signing and notification setup

echo "🍎 Building RedSync for iOS..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Generate iOS-specific files
echo "🔨 Generating iOS files..."
flutter build ios --release

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ iOS build completed successfully!"
    echo "📱 You can now open ios/Runner.xcworkspace in Xcode to:"
    echo "   1. Set up your Apple Developer account and signing"
    echo "   2. Configure notification capabilities"
    echo "   3. Build and deploy to your iPhone"
    echo ""
    echo "📋 Next steps in Xcode:"
    echo "   • Select your development team in Signing & Capabilities"
    echo "   • Enable 'Push Notifications' capability"
    echo "   • Enable 'Background App Refresh' for medication reminders"
    echo "   • Test on a physical iOS device"
else
    echo "❌ iOS build failed. Please check the errors above."
    exit 1
fi
