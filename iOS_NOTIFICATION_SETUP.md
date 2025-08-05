# iOS Notification Setup Guide

## Overview
This guide explains how to set up iOS notifications for the RedSync Mobile App, specifically for medication reminders and message notifications that will appear in the iPhone notification center.

## Features Configured
- **Medication Reminders**: Daily reminders for scheduled medications
- **Message Notifications**: In-app notifications for data sharing requests and updates
- **Background Processing**: Allows notifications even when app is closed
- **Sound & Badge Support**: Full iOS notification experience

## Files Modified for iOS Support

### 1. Info.plist (`ios/Runner/Info.plist`)
Added the following iOS notification permissions:
- `UIBackgroundModes`: Enables background processing for notifications
- `NSUserNotificationUsageDescription`: Explains why the app needs notification permissions
- `UIRequiredDeviceCapabilities`: Ensures compatibility with modern iOS devices

### 2. AppDelegate.swift (`ios/Runner/AppDelegate.swift`)
Enhanced with:
- `UserNotifications` framework import
- Notification permission requests on app launch
- Foreground notification handling
- Notification tap handling

### 3. NotificationService.dart (`lib/services/notification_service.dart`)
Updated with:
- iOS-specific permission handling
- Enhanced DarwinInitializationSettings
- Proper iOS notification configuration

## Building for iOS

### Prerequisites
1. **macOS Computer**: Required for iOS development
2. **Xcode**: Latest version from Mac App Store
3. **Apple Developer Account**: For device testing and App Store deployment
4. **iOS Device**: For testing notifications (simulator has limitations)

### Build Steps

#### Option 1: Using the Build Script
```bash
# Make the script executable (macOS/Linux)
chmod +x build_ios.sh
./build_ios.sh

# Or on Windows
build_ios.bat
```

#### Option 2: Manual Build
```bash
# Clean and get dependencies
flutter clean
flutter pub get

# Build for iOS
flutter build ios --release
```

#### Option 3: Development Build
```bash
# For development/debugging
flutter build ios --debug
```

## Xcode Configuration

After building, open `ios/Runner.xcworkspace` in Xcode and configure:

### 1. Signing & Capabilities
- Select your Apple Developer team
- Ensure bundle identifier is unique
- Add capabilities:
  - ✅ Push Notifications
  - ✅ Background App Refresh
  - ✅ Background Processing

### 2. Deployment Target
- Set minimum iOS version to 12.0 or higher
- Ensure device compatibility

### 3. Notification Settings
The app will automatically request notification permissions when first launched.

## Testing Notifications

### 1. Device Testing
- Install app on physical iOS device
- Grant notification permissions when prompted
- Schedule a medication reminder
- Lock device and wait for notification

### 2. Debug Testing
The app includes test notification functions:
- Immediate test notification
- Scheduled test notification (5 seconds)
- Debug pending notifications

### 3. Verification
Check that notifications appear:
- In iOS Notification Center
- On lock screen
- With sound and badge
- Even when app is closed

## Notification Types

### Medication Reminders
- **When**: Daily at scheduled times
- **Content**: Medication name and dosage
- **Action**: Opens app to mark as taken
- **Repeat**: Daily until manually disabled

### Message Notifications
- **When**: Data sharing requests, provider responses
- **Content**: Brief message about the update
- **Action**: Opens notifications screen
- **Repeat**: One-time per message

## Troubleshooting

### Notifications Not Appearing
1. Check notification permissions in iOS Settings > [App Name] > Notifications
2. Ensure "Allow Notifications" is enabled
3. Check "Badge App Icon" and "Sounds" are enabled
4. Restart the app and re-grant permissions if needed

### Build Issues
1. Ensure Xcode is updated to latest version
2. Check Apple Developer account status
3. Verify iOS deployment target compatibility
4. Clean build folder in Xcode (Product > Clean Build Folder)

### Permission Issues
1. Delete app and reinstall to reset permissions
2. Check iOS Settings > Privacy & Security > Notifications
3. Ensure app has notification permissions

## App Store Submission

When submitting to the App Store:

1. **Privacy Policy**: Update to mention notification usage
2. **App Description**: Clearly describe notification features
3. **Review Notes**: Explain medication reminder functionality
4. **Testing**: Provide test account with sample data

## Technical Details

### Notification Channels
- **Channel ID**: `medication_reminders`
- **Importance**: High priority for medication reminders
- **Sound**: Default iOS notification sound
- **Badge**: Shows unread notification count

### Background Processing
- Uses iOS Background App Refresh
- Schedules local notifications
- No server-side push notifications required
- Works offline

### Data Privacy
- All notifications are local (not sent to external servers)
- Medication data remains on device and user's Firebase
- No third-party notification services used

## Support

For issues related to iOS notifications:
1. Check Flutter documentation for `flutter_local_notifications`
2. Review Apple's iOS notification guidelines
3. Test on multiple iOS versions if possible
4. Consider iOS-specific notification behaviors and limitations
