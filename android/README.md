# Android Build Configuration

## Signing Configuration

This app is configured for release signing. To build a release version:

1. **Create a keystore** (if you haven't already):
   ```bash
   keytool -genkey -v -keystore ~/resistor-calculator-key.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias resistor-calculator
   ```

2. **Configure signing properties**:
   - Copy `key.properties.example` to `key.properties`
   - Fill in your keystore details
   - **Never commit `key.properties` to version control!**

3. **Build release**:
   ```bash
   flutter build appbundle --release
   ```

## Application ID

Current application ID: `com.victorkariuki.resistorcalculator`

This uniquely identifies your app on the Google Play Store. Once published, you cannot change it.

## ProGuard Configuration

The app includes ProGuard rules for code obfuscation and optimization in release builds. Rules are defined in `app/proguard-rules.pro`.

## Build Types

- **Debug**: Uses debug signing, includes debugging symbols
- **Release**: Uses release signing, code obfuscation enabled, optimized

## Troubleshooting

### Signing Errors

If you get signing errors:
1. Verify `key.properties` exists and is correctly formatted
2. Check that the keystore file path is correct
3. Ensure passwords are correct

### Build Errors

If build fails:
```bash
flutter clean
flutter pub get
flutter build appbundle --release
```

