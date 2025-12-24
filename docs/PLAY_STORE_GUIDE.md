# Google Play Store Submission Guide

This guide will help you prepare and submit the Resistor Calculator app to the Google Play Store.

## Prerequisites

1. **Google Play Developer Account**
   - Sign up at [Google Play Console](https://play.google.com/console)
   - Pay the one-time $25 registration fee
   - Complete your developer profile

2. **Android Development Environment**
   - Flutter SDK installed and configured
   - Android Studio or command line tools
   - Java Development Kit (JDK) 11 or higher

## Step 1: Generate a Signing Key

### Create a Keystore

```bash
keytool -genkey -v -keystore ~/resistor-calculator-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias resistor-calculator
```

**Important Notes:**
- Replace `~/resistor-calculator-key.jks` with your desired keystore path
- Replace `resistor-calculator` with your desired key alias
- **Remember your passwords** - you'll need them for future updates
- **Back up your keystore file** - losing it means you can't update your app

### Configure Signing

1. Copy the example key properties file:
   ```bash
   cp android/key.properties.example android/key.properties
   ```

2. Edit `android/key.properties` with your actual values:
   ```properties
   storePassword=your_keystore_password
   keyPassword=your_key_password
   keyAlias=resistor-calculator
   storeFile=../resistor-calculator-key.jks
   ```

3. **Add `key.properties` to `.gitignore`** (never commit this file!)

## Step 2: Update App Information

### Application ID
The app is configured with: `com.victorkariuki.resistorcalculator`

If you want to change it:
1. Update `android/app/build.gradle.kts` - `applicationId`
2. Update `android/app/build.gradle.kts` - `namespace`
3. Update package name in `android/app/src/main/kotlin/` directory structure

### Version Information
Current version in `pubspec.yaml`: `1.0.0+1`
- Version name: `1.0.0` (user-visible)
- Version code: `1` (internal, must increment for each release)

## Step 3: Build the Release APK/AAB

### Build App Bundle (Recommended for Play Store)

```bash
flutter build appbundle --release
```

The output will be at: `build/app/outputs/bundle/release/app-release.aab`

### Build APK (Alternative)

```bash
flutter build apk --release
```

The output will be at: `build/app/outputs/flutter-apk/app-release.apk`

**Note:** Google Play prefers App Bundles (.aab) as they allow optimized delivery.

## Step 4: Test the Release Build

Before submitting, test your release build:

```bash
# Install on a connected device
flutter install --release

# Or install the APK directly
adb install build/app/outputs/flutter-apk/app-release.apk
```

Test all features to ensure everything works correctly.

## Step 5: Prepare Store Listing Assets

### Required Assets

1. **App Icon**
   - 512 x 512 pixels (PNG, 32-bit)
   - Already configured via `flutter_launcher_icons`

2. **Feature Graphic**
   - 1024 x 500 pixels (PNG or JPG)
   - Displayed at the top of your store listing

3. **Screenshots**
   - Phone: At least 2, up to 8 screenshots
   - Tablet (if supported): At least 2, up to 8 screenshots
   - Minimum: 320px, Maximum: 3840px
   - Aspect ratio: 16:9 or 9:16

4. **Promotional Graphics** (Optional but recommended)
   - Promo graphic: 180 x 120 pixels
   - TV banner: 1280 x 720 pixels (if TV support)

### Content Rating

You'll need to complete a content rating questionnaire. For this app:
- No violence, sexual content, or mature themes
- Should receive "Everyone" rating

### Privacy Policy

**Required** - You must provide a privacy policy URL. Since this app:
- Doesn't collect personal data
- Doesn't use analytics (unless you add them)
- Operates offline

You can create a simple privacy policy stating this.

## Step 6: Create Store Listing

### App Details

- **App name:** Resistor Calculator
- **Short description:** (80 characters max)
  ```
  Calculate resistor values from color codes, SMD codes, and find standard values.
  ```
- **Full description:** (4000 characters max)
  ```
  Resistor Calculator is a comprehensive tool for electronics hobbyists and professionals. 
  
  Features:
  • Resistor Color Code Calculator - Decode 4-band, 5-band, and 6-band resistors
  • SMD Resistor Decoder - Decode 3-digit, 4-digit, and EIA-96 codes
  • E-Series Finder - Find standard resistor values (E6, E12, E24, E48, E96, E192)
  • Junk Box Solver - Find resistor combinations from available parts
  • Power Analysis - Calculate power dissipation
  • Voltage Divider Calculator
  • L-Match Impedance Matching
  • Favorites & History
  • Dark/Light theme support
  
  Perfect for electronics projects, circuit design, and component selection.
  ```

### Category

- **Primary:** Tools
- **Secondary:** Education (optional)

### Contact Details

- Email address for support
- Website (if available)
- Privacy policy URL

## Step 7: Upload and Submit

1. **Go to Google Play Console**
   - Navigate to your app
   - Click "Create new release"

2. **Upload App Bundle**
   - Upload the `.aab` file from Step 3
   - Add release notes (what's new in this version)

3. **Review and Rollout**
   - Review all sections (green checkmarks)
   - Submit for review
   - Google typically reviews within 1-3 days

## Step 8: Post-Submission

### Monitor Your App

- Check the Play Console for review status
- Respond to any policy violations or issues
- Monitor user reviews and ratings

### Update Process

For future updates:

1. Increment version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # versionName+versionCode
   ```

2. Build new release:
   ```bash
   flutter build appbundle --release
   ```

3. Upload to Play Console
4. Add release notes
5. Submit for review

## Troubleshooting

### Build Errors

- **Signing errors:** Verify `key.properties` is correct
- **Gradle errors:** Run `flutter clean` and rebuild
- **Version conflicts:** Ensure version code increments

### Play Console Issues

- **App rejected:** Check policy violations in Play Console
- **Missing assets:** Ensure all required screenshots are uploaded
- **Content rating:** Complete the questionnaire accurately

## Security Best Practices

1. **Never commit `key.properties`** to version control
2. **Back up your keystore** in a secure location
3. **Use different keystores** for different apps
4. **Keep keystore passwords** in a secure password manager

## Additional Resources

- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [Flutter Deployment Guide](https://docs.flutter.dev/deployment/android)
- [App Bundle Guide](https://developer.android.com/guide/app-bundle)
- [Play Store Policies](https://play.google.com/about/developer-content-policy/)

## Checklist

Before submitting, ensure:

- [ ] Keystore created and configured
- [ ] `key.properties` added to `.gitignore`
- [ ] App bundle built successfully
- [ ] Release build tested on device
- [ ] App icon and screenshots prepared
- [ ] Store listing content written
- [ ] Privacy policy URL ready
- [ ] Content rating questionnaire completed
- [ ] All required fields in Play Console filled
- [ ] App reviewed for policy compliance

Good luck with your submission! 🚀

