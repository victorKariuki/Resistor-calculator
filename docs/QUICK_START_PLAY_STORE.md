# Quick Start: Google Play Store Submission

## 🚀 Quick Steps

### 1. Generate Signing Key (One-time setup)

```bash
keytool -genkey -v -keystore ~/resistor-calculator-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias resistor-calculator
```

**Important:** Save your passwords securely!

### 2. Configure Signing

```bash
# Copy the example file
cp android/key.properties.example android/key.properties

# Edit android/key.properties with your keystore details:
# storePassword=your_keystore_password
# keyPassword=your_key_password
# keyAlias=resistor-calculator
# storeFile=../resistor-calculator-key.jks
```

### 3. Build Release Bundle

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### 4. Test Release Build

```bash
flutter install --release
```

### 5. Submit to Play Store

1. Go to [Google Play Console](https://play.google.com/console)
2. Create new app or select existing
3. Upload `app-release.aab`
4. Complete store listing
5. Submit for review

## 📋 Pre-Submission Checklist

- [ ] Keystore created and backed up
- [ ] `key.properties` configured (not committed to git)
- [ ] App bundle built successfully
- [ ] Release build tested on device
- [ ] App icon ready (512x512)
- [ ] Screenshots prepared (at least 2)
- [ ] Store listing content written
- [ ] Privacy policy URL ready
- [ ] Content rating completed

## 📚 Full Documentation

See [PLAY_STORE_GUIDE.md](PLAY_STORE_GUIDE.md) for detailed instructions.

## ⚠️ Important Notes

- **Never commit `key.properties` or `.jks` files**
- **Back up your keystore** - losing it means you can't update your app
- **Increment version code** for each release (in `pubspec.yaml`)
- **Test thoroughly** before submitting

## 🔧 Troubleshooting

**Build fails?**
```bash
flutter clean
flutter pub get
flutter build appbundle --release
```

**Signing errors?**
- Check `key.properties` exists and is correct
- Verify keystore file path
- Ensure passwords are correct

