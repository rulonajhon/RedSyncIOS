# Complete macOS Build & Deploy Guide for RedSync iOS App

## 🍎 Prerequisites on Mac

### 1. Hardware Requirements
- **Mac Computer** (MacBook, iMac, Mac mini, or Mac Studio)
- **iPhone/iPad** for testing (iOS 12.0 or later)
- **USB Cable** to connect iPhone to Mac

### 2. Software Requirements
- **macOS** (latest version recommended)
- **Apple Developer Account** ($99/year for App Store deployment)
- **Xcode** (latest version from Mac App Store)
- **Flutter** (latest stable version)

## 📋 Step-by-Step Build Process

### Step 1: Transfer Project to Mac
```bash
# Option A: Use Git (Recommended)
git clone https://github.com/rulonajhon/RedSync_MobileApp.git
cd RedSync_MobileApp

# Option B: Copy via USB/Cloud
# Transfer the entire project folder to your Mac
# Navigate to the project directory
cd /path/to/RedSync_MobileApp
```

### Step 2: Install macOS Development Tools

#### Install Xcode
```bash
# Install from Mac App Store (free, ~12GB download)
# Open Mac App Store → Search "Xcode" → Install

# Or via command line (if you have developer tools)
xcode-select --install
```

#### Install Flutter
```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add Flutter to PATH
echo 'export PATH="$PATH:`pwd`/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify installation
flutter doctor
```

#### Install CocoaPods (Required for iOS)
```bash
# Install CocoaPods for iOS dependencies
sudo gem install cocoapods
pod setup
```

### Step 3: Configure Flutter Environment
```bash
# Check Flutter setup
flutter doctor

# You should see:
# ✅ Flutter (Channel stable)
# ✅ Android toolchain (if Android Studio installed)
# ✅ Xcode - develop for iOS and macOS
# ✅ iOS toolchain
# ✅ Connected device (when iPhone connected)

# Accept iOS licenses
sudo xcodebuild -license accept
```

### Step 4: Setup Apple Developer Account

#### Create/Login to Apple Developer Account
1. Go to [developer.apple.com](https://developer.apple.com)
2. Sign in with your Apple ID
3. Enroll in Apple Developer Program ($99/year)
4. Complete verification process

#### Setup Development Certificates
```bash
# Open Xcode
open -a Xcode

# Sign in to Xcode with Apple ID:
# Xcode → Preferences → Accounts → Add Apple ID
```

### Step 5: Prepare Project for iOS Build

#### Navigate to Project and Get Dependencies
```bash
cd /path/to/RedSync_MobileApp

# Clean any previous builds
flutter clean

# Get Flutter dependencies
flutter pub get

# Get iOS dependencies
cd ios
pod install
cd ..
```

#### Configure iOS Bundle Identifier
```bash
# Open iOS project in Xcode
open ios/Runner.xcworkspace
```

**In Xcode:**
1. Select **Runner** in project navigator
2. Go to **Signing & Capabilities** tab
3. Set **Bundle Identifier** to unique value:
   - Example: `com.yourname.redsync` or `com.yourcompany.hemophilia-manager`
4. Select your **Team** (Apple Developer account)

### Step 6: Configure iOS Capabilities

**In Xcode → Signing & Capabilities:**

#### Add Required Capabilities
1. Click **"+ Capability"** button
2. Add these capabilities:
   - ✅ **Push Notifications**
   - ✅ **Background App Refresh**
   - ✅ **Background Processing**

#### Verify Info.plist Settings
The following should already be configured (we set this up earlier):
```xml
<!-- Notification Permissions -->
<key>UIBackgroundModes</key>
<array>
    <string>background-processing</string>
    <string>background-fetch</string>
</array>

<!-- Notification usage description -->
<key>NSUserNotificationUsageDescription</key>
<string>This app needs to send you medication reminders and important health notifications.</string>
```

### Step 7: Build the iOS App

#### Option A: Build via Flutter Command
```bash
# Build iOS app
flutter build ios

# Build for specific device (optional)
flutter build ios --flavor production
```

#### Option B: Build via Xcode
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select target device (your iPhone or simulator)
3. Click **Product → Build** (⌘+B)

### Step 8: Deploy to iPhone

#### Connect iPhone to Mac
1. Connect iPhone via USB cable
2. Unlock iPhone and trust computer when prompted
3. Keep iPhone unlocked during deployment

#### Deploy via Xcode
```bash
# Open project in Xcode
open ios/Runner.xcworkspace
```

**In Xcode:**
1. Select your **connected iPhone** from device dropdown
2. Click **Play button** (▶️) or **Product → Run** (⌘+R)
3. Wait for build and deployment to complete

#### Deploy via Flutter Command
```bash
# List connected devices
flutter devices

# Deploy to connected iPhone
flutter run --release -d "iPhone Name"
```

### Step 9: Test Notifications on iPhone

#### Initial Setup
1. **Launch app** on iPhone
2. **Grant notification permissions** when prompted
3. **Allow location access** for clinic finder feature

#### Test Medication Reminders
```bash
# In the app:
1. Go to "Schedule Medication"
2. Enter medication name (e.g., "Factor VIII")
3. Set dosage (e.g., "500 IU")
4. Set reminder time (1-2 minutes from now)
5. Enable notifications toggle
6. Save schedule

# Lock iPhone and wait for notification
# Should appear on lock screen with sound
```

#### Verify Notification Center Integration
- Lock screen notification ✅
- Notification center entry ✅
- Badge on app icon ✅
- Sound alert ✅
- Swipe actions ✅

## 🔧 Troubleshooting Common Issues

### Build Errors

#### "No iOS devices available"
```bash
# Check connected devices
flutter devices
xcrun devicectl list

# Trust computer on iPhone
# Settings → General → Device Management → Trust Computer
```

#### "Code signing error"
```bash
# In Xcode:
# 1. Select Runner target
# 2. Signing & Capabilities
# 3. Select correct team
# 4. Let Xcode automatically manage signing
```

#### "CocoaPods error"
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

#### "Flutter doctor issues"
```bash
# Fix common issues
flutter doctor --android-licenses  # If Android needed
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
flutter doctor -v  # Detailed diagnosis
```

### Runtime Issues

#### "Notifications not appearing"
```bash
# Check iPhone settings:
# Settings → [App Name] → Notifications → Allow Notifications: ON
# Enable Lock Screen, Notification Center, Banners
# Enable Sounds and Badges

# Reset app permissions:
# Delete app from iPhone → Reinstall → Grant permissions again
```

#### "App crashes on launch"
```bash
# Check device logs in Xcode:
# Window → Devices and Simulators → Select iPhone → Open Console
# Look for crash logs with your app name
```

## 📱 Deployment Options

### Development Deployment (Free)
- Deploy to your own devices
- Up to 3 devices per Apple ID
- Apps expire after 7 days
- Perfect for testing

### App Store Deployment ($99/year)
- Deploy to App Store
- Unlimited distribution
- No expiration
- Requires App Store review

### TestFlight Distribution (with Developer Account)
- Beta testing with up to 10,000 users
- Apps expire after 90 days
- No App Store review required
- Great for user testing

## 🚀 Distribution Commands

### Create Archive for App Store
```bash
# Build archive
flutter build ipa

# Or in Xcode:
# Product → Archive → Distribute App → App Store Connect
```

### Upload to App Store Connect
```bash
# Using Xcode:
# After archiving → Distribute App → App Store Connect → Upload

# Or using command line:
xcrun altool --upload-app -f build/ios/ipa/*.ipa -u your-apple-id -p app-specific-password
```

## ✅ Final Checklist

### Before Building:
- [ ] Mac with Xcode installed
- [ ] Apple Developer account active
- [ ] iPhone connected and trusted
- [ ] Flutter environment working (`flutter doctor`)
- [ ] CocoaPods installed

### Before Deploying:
- [ ] Bundle identifier configured
- [ ] Signing certificates valid
- [ ] Capabilities added (Push Notifications, Background App Refresh)
- [ ] Device selected in Xcode
- [ ] iPhone unlocked and connected

### After Deployment:
- [ ] App launches successfully
- [ ] Notification permissions granted
- [ ] Test medication reminder works
- [ ] Notifications appear on lock screen
- [ ] App functions as expected

## 🎉 Success!

Once deployed, your RedSync app will have:
- ✅ Full iPhone notification center integration
- ✅ Medication reminders with sound and badges
- ✅ Background notification processing
- ✅ Lock screen notification display
- ✅ Healthcare provider message alerts
- ✅ Native iOS user experience

Your patients can now receive medication reminders directly through their iPhone's notification system, making it much more likely they'll see and respond to important medication schedules!

---

**Need help?** Check the troubleshooting section above or run `flutter doctor -v` for detailed diagnostics.
