# Quick macOS Setup Commands

## Copy these commands to run on your Mac:

### 1. Install Flutter (if not installed)
```bash
# Download and install Flutter
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

### 2. Install CocoaPods
```bash
sudo gem install cocoapods
pod setup
```

### 3. Accept Xcode License
```bash
sudo xcodebuild -license accept
```

### 4. Transfer and Build Project
```bash
# Navigate to your project folder
cd /path/to/RedSync_MobileApp

# Make build script executable
chmod +x mac_build_deploy.sh

# Run the automated build script
./mac_build_deploy.sh
```

### 5. Manual Build (Alternative)
```bash
# Clean and prepare
flutter clean
flutter pub get

# Install iOS dependencies
cd ios && pod install && cd ..

# Build for iOS
flutter build ios --release

# Open in Xcode
open ios/Runner.xcworkspace
```

### 6. Deploy to iPhone
```bash
# List connected devices
flutter devices

# Deploy to iPhone (replace with your device name)
flutter run --release -d "Your iPhone Name"
```

### 7. Configure in Xcode
1. Open `ios/Runner.xcworkspace`
2. Select Runner → Signing & Capabilities
3. Set Bundle Identifier: `com.yourname.redsync`
4. Select your Apple Developer Team
5. Add Capabilities:
   - Push Notifications
   - Background App Refresh
   - Background Processing

### 8. Test Notifications
1. Install app on iPhone
2. Grant notification permissions
3. Schedule medication reminder
4. Lock iPhone and wait for notification

## Ready to go! 🚀
