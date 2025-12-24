# Resistor Calculator

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

Before you begin, ensure you have the following installed:

- **Flutter SDK** (version 3.9.0 or higher)
  - Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
  - Verify installation: `flutter --version`
- **Dart SDK** (comes with Flutter)
- **Git** (for version control)
- **IDE/Editor** (recommended):
  - [VS Code](https://code.visualstudio.com/) with Flutter extension
  - [Android Studio](https://developer.android.com/studio) with Flutter plugin
  - [IntelliJ IDEA](https://www.jetbrains.com/idea/) with Flutter plugin

### Platform-Specific Requirements

#### Android Development
- **Android Studio** with Android SDK
- **Android SDK Platform-Tools**
- **Java Development Kit (JDK)** 11 or higher
- An Android device or emulator

#### iOS Development (macOS only)
- **Xcode** (latest version from App Store)
- **CocoaPods**: `sudo gem install cocoapods`
- **Xcode Command Line Tools**: `xcode-select --install`
- An iOS device or simulator

#### Web Development
- **Chrome** (for testing)

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/victorKariuki/Resistor-calculator.git
cd Resistor-calculator
```

### 2. Verify Flutter Installation

```bash
flutter doctor
```

This command checks your environment and displays a report. Fix any issues reported before proceeding.

### 3. Install Dependencies

```bash
flutter pub get
```

This installs all packages listed in `pubspec.yaml`.

### 4. Verify Setup

```bash
flutter analyze
```

This checks for any static analysis issues in the code.

### 5. Run the Application

#### Development Mode

```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices  # List available devices
flutter run -d <device-id>

# Run in Chrome (web)
flutter run -d chrome

# Run with hot reload enabled (default)
# Press 'r' in terminal to hot reload
# Press 'R' to hot restart
# Press 'q' to quit
```

#### Release Mode

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

### 6. Generate Launcher Icons (Optional)

If you modify the app icon, regenerate launcher icons:

```bash
flutter pub run flutter_launcher_icons
```

## Development Workflow

### Code Formatting

```bash
# Format all Dart files
dart format .

# Format specific file
dart format lib/main.dart
```

### Static Analysis

```bash
# Run analyzer
flutter analyze

# Auto-fix issues where possible
flutter fix --apply
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## Contributing

We welcome contributions! Please follow these guidelines to ensure a smooth collaboration.

### Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Resistor-calculator.git
   cd Resistor-calculator
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/victorKariuki/Resistor-calculator.git
   ```

### Development Process

1. **Create a feature branch** from `master` (or `develop` if it exists):
   ```bash
   git checkout master
   git pull upstream master
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**:
   - Follow the existing code style
   - Write clear, descriptive commit messages
   - Add comments for complex logic
   - Update documentation if needed

3. **Test your changes**:
   ```bash
   flutter analyze
   flutter test
   flutter run
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```

   Use conventional commit messages:
   - `feat:` for new features
   - `fix:` for bug fixes
   - `docs:` for documentation changes
   - `style:` for code style changes (formatting, etc.)
   - `refactor:` for code refactoring
   - `test:` for adding or updating tests
   - `chore:` for maintenance tasks

5. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**:
   - Go to [the repository](https://github.com/victorKariuki/Resistor-calculator) on GitHub
   - Click "New Pull Request"
   - Select your fork and feature branch
   - Fill out the PR template (if available)
   - Wait for code review

### Code Style Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format .` before committing
- Fix all `flutter analyze` warnings
- Write self-documenting code with clear variable names
- Keep functions focused and small
- Add comments for complex algorithms or business logic

### Pull Request Guidelines

- **Title**: Clear, descriptive title using conventional commits format
- **Description**: Explain what changes you made and why
- **Testing**: Describe how you tested your changes
- **Screenshots**: Include screenshots for UI changes
- **Breaking Changes**: Clearly mark any breaking changes
- **Related Issues**: Reference related issues using `#issue-number`

### Review Process

- All PRs require at least one approval before merging
- Address review comments promptly
- Keep PRs focused and reasonably sized
- Rebase on `master` (or `develop` if it exists) if requested

## Security

### Reporting Security Vulnerabilities

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via one of the following methods:

1. **Email**: Send details to the repository maintainer via GitHub profile
2. **Private Security Advisory**: Use GitHub's private security advisory feature if enabled
3. **GitHub Security Tab**: Navigate to the [Security tab](https://github.com/victorKariuki/Resistor-calculator/security) and create a private security advisory

### Security Best Practices

#### For Contributors

- **Never commit secrets**: API keys, passwords, tokens, or any sensitive data
- **Review dependencies**: Be cautious when adding new packages
- **Validate inputs**: Always validate and sanitize user inputs
- **Use secure storage**: Use `shared_preferences` or secure storage for sensitive data
- **Keep dependencies updated**: Regularly update packages to patch vulnerabilities

#### Security Checklist

Before submitting a PR, ensure:

- [ ] No hardcoded secrets or credentials
- [ ] User inputs are validated and sanitized
- [ ] Dependencies are up-to-date and from trusted sources
- [ ] No sensitive data is logged or exposed
- [ ] Permissions are requested only when necessary
- [ ] Network requests use HTTPS

#### Dependency Security

```bash
# Check for known vulnerabilities in dependencies
flutter pub outdated

# Update dependencies
flutter pub upgrade

# Audit dependencies (if using pub.dev security features)
flutter pub audit
```

#### Secure Storage

The app uses `shared_preferences` for local storage. For sensitive data, consider:

- Using `flutter_secure_storage` package for sensitive information
- Encrypting data before storing
- Not storing sensitive data locally when possible

## Gitflow Workflow

This project follows the [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) for managing branches and releases.

### Branch Structure

```
master (production)
  └── develop (integration) [optional - can start with master]
       ├── feature/* (new features)
       ├── bugfix/* (bug fixes)
       ├── hotfix/* (urgent production fixes)
       └── release/* (release preparation)
```

**Note**: Currently, the repository uses `master` as the default branch. You may want to create a `develop` branch for integration, or work directly from `master` for smaller projects.

### Branch Types

#### `master`
- **Purpose**: Production-ready code
- **Protection**: Should be protected branch, requires PR from `develop` or `hotfix/*`
- **Merges**: Only from `develop` (releases) or `hotfix/*` branches
- **Current Status**: Default branch in this repository

#### `develop` (Optional)
- **Purpose**: Integration branch for development
- **Protection**: Should be protected branch, requires PR from feature/bugfix branches
- **Merges**: From `feature/*`, `bugfix/*`, and `release/*` branches
- **Setup**: Create this branch if you want to follow full Gitflow:
  ```bash
  git checkout -b develop
  git push -u origin develop
  ```

#### `feature/*`
- **Purpose**: New features
- **Naming**: `feature/feature-name` (e.g., `feature/add-capacitor-calculator`)
- **Base**: Branch from `develop` (if exists) or `master`
- **Merge**: Back to `develop` (or `master`) via PR

#### `bugfix/*`
- **Purpose**: Bug fixes for development
- **Naming**: `bugfix/bug-description` (e.g., `bugfix/fix-resistor-calculation`)
- **Base**: Branch from `develop` (if exists) or `master`
- **Merge**: Back to `develop` (or `master`) via PR

#### `hotfix/*`
- **Purpose**: Urgent fixes for production
- **Naming**: `hotfix/issue-description` (e.g., `hotfix/critical-crash-fix`)
- **Base**: Branch from `master`
- **Merge**: Back to both `master` and `develop` (if exists)

#### `release/*`
- **Purpose**: Prepare new production release
- **Naming**: `release/version-number` (e.g., `release/1.1.0`)
- **Base**: Branch from `develop` (if exists) or `master`
- **Merge**: Back to both `master` and `develop` (if exists)

### Gitflow Commands

#### Initialize Gitflow (First Time)

```bash
# Install git-flow (if not already installed)
# macOS
brew install git-flow-avh

# Linux
sudo apt-get install git-flow

# Ubuntu/Debian
sudo apt-get install git-flow

# Initialize in repository
git flow init
# Accept defaults or customize as needed
# For this repo, use 'master' as production branch
```

#### Feature Workflow

```bash
# Start a new feature (from master if develop doesn't exist)
git checkout master
git pull upstream master
git checkout -b feature/feature-name

# Work on your feature, commit changes
git add .
git commit -m "feat: implement feature"

# Push and create PR
git push origin feature/feature-name
# Then create PR on GitHub

# Or if using git-flow and develop exists:
git flow feature start feature-name
# ... make changes ...
git flow feature finish feature-name
```

#### Bugfix Workflow

```bash
# Start a bugfix
git checkout master  # or develop if it exists
git pull upstream master
git checkout -b bugfix/bug-description

# Make fixes and commit
git add .
git commit -m "fix: resolve bug description"

# Push and create PR
git push origin bugfix/bug-description
```

#### Hotfix Workflow

```bash
# Start a hotfix (branches from master)
git checkout master
git pull upstream master
git checkout -b hotfix/issue-description

# Make urgent fixes
git add .
git commit -m "fix: critical issue fix"

# Push and create PRs
git push origin hotfix/issue-description
# Create PR to master, and to develop if it exists
```

#### Release Workflow

```bash
# Start a release
git checkout master  # or develop if it exists
git pull upstream master
git checkout -b release/1.1.0

# Update version numbers, changelog, etc.
# In pubspec.yaml: version: 1.1.0+1

# Push and create PR
git push origin release/1.1.0
# Create PR to master
```

### Manual Gitflow (Without git-flow tool)

```bash
# Feature
git checkout master
git pull upstream master
git checkout -b feature/feature-name
# ... make changes ...
git push origin feature/feature-name
# Create PR to master (or develop if it exists)

# Hotfix
git checkout master
git pull upstream master
git checkout -b hotfix/issue-description
# ... make fixes ...
git push origin hotfix/issue-description
# Create PRs to master and develop (if exists)

# Release
git checkout master  # or develop if it exists
git pull upstream master
git checkout -b release/1.1.0
# ... prepare release ...
git push origin release/1.1.0
# Create PR to master
```

### Version Numbering

Follow [Semantic Versioning](https://semver.org/):

- **MAJOR.MINOR.PATCH+BUILD** (e.g., `1.2.3+4`)
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes
- **BUILD**: Build number (increment for each release)

Update in `pubspec.yaml`:
```yaml
version: 1.2.3+4
```

## Troubleshooting

### Common Issues

#### Flutter Doctor Issues

```bash
# Update Flutter
flutter upgrade

# Clean and reinstall
flutter clean
flutter pub get
```

#### Build Issues

```bash
# Clean build
flutter clean
flutter pub get
flutter run

# For Android
cd android
./gradlew clean
cd ..
flutter run

# For iOS (macOS only)
cd ios
pod deintegrate
pod install
cd ..
flutter run
```

#### Dependency Issues

```bash
# Clear pub cache
flutter pub cache repair

# Remove pubspec.lock and reinstall
rm pubspec.lock
flutter pub get
```

## License

[Add your license here - consider MIT, Apache 2.0, or GPL]

## Acknowledgments

- Flutter team for the amazing framework
- All contributors who have helped improve this project
- The electronics community for inspiration and feedback

## Links

- **Repository**: [https://github.com/victorKariuki/Resistor-calculator](https://github.com/victorKariuki/Resistor-calculator)
- **Issues**: [https://github.com/victorKariuki/Resistor-calculator/issues](https://github.com/victorKariuki/Resistor-calculator/issues)
- **Pull Requests**: [https://github.com/victorKariuki/Resistor-calculator/pulls](https://github.com/victorKariuki/Resistor-calculator/pulls)

## Contact

For questions, suggestions, or support, please:
- Open an [issue](https://github.com/victorKariuki/Resistor-calculator/issues) on GitHub
- Contact the repository maintainer via GitHub profile
