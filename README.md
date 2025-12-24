# Resistor Calculator

[![Flutter CI](https://github.com/victorKariuki/Resistor-calculator/actions/workflows/flutter.yml/badge.svg)](https://github.com/victorKariuki/Resistor-calculator/actions/workflows/flutter.yml)
[![Dart CI](https://github.com/victorKariuki/Resistor-calculator/actions/workflows/dart.yml/badge.svg)](https://github.com/victorKariuki/Resistor-calculator/actions/workflows/dart.yml)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Flutter](https://img.shields.io/badge/Flutter-3.9.0+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.0+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey)](https://flutter.dev)
[![Contributors](https://img.shields.io/github/contributors/victorKariuki/Resistor-calculator)](https://github.com/victorKariuki/Resistor-calculator/graphs/contributors)
[![Issues](https://img.shields.io/github/issues/victorKariuki/Resistor-calculator)](https://github.com/victorKariuki/Resistor-calculator/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/victorKariuki/Resistor-calculator)](https://github.com/victorKariuki/Resistor-calculator/pulls)

Resistor Calculator is a Flutter application designed to assist electronics hobbyists and professionals with resistor-related calculations. Whether you're decoding a resistor's value from its color bands, deciphering an SMD code, or finding the nearest standard resistor value, this app has you covered.

## Features

*   **Resistor Color Code Calculator:** Easily determine the resistance value of a through-hole resistor by selecting its color bands. The app supports 4-band and 5-band resistors.
*   **SMD Resistor Decoder:** Quickly find the value of a surface-mount (SMD) resistor by entering its 3 or 4-digit code, or its EIA-96 code.
*   **"Junk Box" E-Series Solver:** Find the nearest standard resistor value from the common E-series (E6, E12, E24, E48, E96, E192). This feature is perfect for when you need to find a suitable replacement resistor from your collection of parts.
*   **Power Analysis:** Calculate power dissipation in resistors.
*   **Voltage Divider Calculator:** Calculate output voltage of voltage divider circuits.
*   **L-Match Impedance Matching:** Calculate component values for L-match impedance matching networks.
*   **Favorites & History:** Save favorite resistor values and view calculation history.
*   **Dark/Light Mode:** Support for both light and dark themes.

## Prerequisites

- **Flutter SDK** (version 3.9.0 or higher) - [Download](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (comes with Flutter)
- **Git** (for version control)
- **IDE/Editor** (VS Code, Android Studio, or IntelliJ IDEA with Flutter extensions)

### Platform-Specific Requirements

- **Android**: Android Studio, Android SDK, JDK 11+
- **iOS** (macOS only): Xcode, CocoaPods
- **Web**: Chrome (for testing)

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/victorKariuki/Resistor-calculator.git
cd Resistor-calculator
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

```bash
# Development mode
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run in Chrome (web)
flutter run -d chrome
```

### 4. Build for Release

```bash
# Android APK
flutter build apk

# Android App Bundle (for Play Store)
flutter build appbundle

# iOS (macOS only)
flutter build ios

# Web
flutter build web
```

## Development

### Basic Commands

```bash
# Format code
dart format .

# Run static analysis
flutter analyze

# Run tests
flutter test

# Generate launcher icons (if modified)
flutter pub run flutter_launcher_icons
```

For detailed development guidelines, see [CONTRIBUTING.md](CONTRIBUTING.md).

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines on:

- Development setup and workflow
- Code style and conventions
- Commit message guidelines
- Pull request process
- Testing requirements

Please also read our [Code of Conduct](CODE_OF_CONDUCT.md) before contributing.

## Security

For security concerns, please see [SECURITY.md](SECURITY.md) for:

- How to report security vulnerabilities
- Security best practices
- Security checklist for contributors

**Please do not report security vulnerabilities through public GitHub issues.**

## Gitflow Workflow

This project follows the [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) for managing branches and releases.

### Quick Reference

- **`master`**: Production-ready code
- **`develop`**: Integration branch (optional)
- **`feature/*`**: New features
- **`bugfix/*`**: Bug fixes
- **`hotfix/*`**: Urgent production fixes
- **`release/*`**: Release preparation

### Version Numbering

Follow [Semantic Versioning](https://semver.org/): **MAJOR.MINOR.PATCH+BUILD**

Example: `1.2.3+4` in `pubspec.yaml`

For detailed Gitflow commands and workflows, see the [Contributing Guide](CONTRIBUTING.md#development-process).

## Troubleshooting

### Flutter Doctor Issues

```bash
flutter upgrade
flutter clean
flutter pub get
```

### Build Issues

```bash
# Clean build
flutter clean
flutter pub get
flutter run

# Android specific
cd android && ./gradlew clean && cd ..

# iOS specific (macOS only)
cd ios && pod deintegrate && pod install && cd ..
```

### Dependency Issues

```bash
flutter pub cache repair
rm pubspec.lock
flutter pub get
```

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Links

- **Repository**: [https://github.com/victorKariuki/Resistor-calculator](https://github.com/victorKariuki/Resistor-calculator)
- **Issues**: [https://github.com/victorKariuki/Resistor-calculator/issues](https://github.com/victorKariuki/Resistor-calculator/issues)
- **Pull Requests**: [https://github.com/victorKariuki/Resistor-calculator/pulls](https://github.com/victorKariuki/Resistor-calculator/pulls)

## Acknowledgments

- Flutter team for the amazing framework
- All contributors who have helped improve this project
- The electronics community for inspiration and feedback

## Contact

For questions, suggestions, or support:
- Open an [issue](https://github.com/victorKariuki/Resistor-calculator/issues) on GitHub
- Contact the repository maintainer via GitHub profile
