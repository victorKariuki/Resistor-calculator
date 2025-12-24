# Contributing to Resistor Calculator

Thank you for your interest in contributing to Resistor Calculator! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)
- [Code Style](#code-style)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors, regardless of background or experience level.

### Expected Behavior

- Be respectful and considerate
- Welcome newcomers and help them learn
- Focus on constructive feedback
- Accept criticism gracefully
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discriminatory language
- Personal attacks or trolling
- Publishing others' private information
- Any conduct that could reasonably be considered inappropriate

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Resistor-calculator.git
   cd Resistor-calculator
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/victorKariuki/Resistor-calculator.git
   ```
4. **Create a branch** for your work:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

### Prerequisites

- Flutter SDK 3.9.0 or higher
- Dart SDK (comes with Flutter)
- Git
- Your preferred IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Initial Setup

```bash
# Install dependencies
flutter pub get

# Verify setup
flutter doctor
flutter analyze
```

### Running the App

```bash
# Development mode with hot reload
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run tests
flutter test
```

## Making Changes

### Before You Start

1. **Check existing issues**: Look for open issues that match what you want to work on
2. **Create an issue**: If you're adding a new feature, create an issue first to discuss it
3. **Assign yourself**: Comment on the issue to let others know you're working on it

### Development Workflow

1. **Update your fork**:
   ```bash
   git checkout master
   git pull upstream master
   ```

2. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**:
   - Write clean, readable code
   - Follow the existing code style
   - Add comments for complex logic
   - Update documentation as needed

4. **Test your changes**:
   ```bash
   flutter analyze
   flutter test
   flutter run
   ```

5. **Commit your changes** (see [Commit Message Guidelines](#commit-message-guidelines))

6. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request** on GitHub

## Commit Message Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Code style changes (formatting, missing semicolons, etc.)
- `refactor`: Code refactoring without changing functionality
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks, dependency updates
- `ci`: CI/CD changes

### Examples

```
feat(decoder): add 6-band resistor support

Add support for decoding 6-band resistors with temperature coefficient.
This extends the existing decoder to handle precision resistors.

Closes #123
```

```
fix(calculator): correct power calculation formula

The power calculation was using voltage squared instead of current squared.
This fixes incorrect power dissipation values.

Fixes #456
```

```
docs(readme): update setup instructions

Add iOS-specific setup steps and troubleshooting section.
```

## Pull Request Process

### Before Submitting

- [ ] Code follows the project's style guidelines
- [ ] All tests pass (`flutter test`)
- [ ] Code has been analyzed (`flutter analyze`)
- [ ] Documentation has been updated
- [ ] Commit messages follow the guidelines
- [ ] Branch is up to date with `master`

### PR Title and Description

**Title**: Use conventional commit format
```
feat: add capacitor calculator
```

**Description Template**:
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How was this tested?

## Screenshots (if applicable)
Add screenshots for UI changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
```

### Review Process

1. **Automated Checks**: CI will run tests and analysis
2. **Code Review**: At least one maintainer will review
3. **Address Feedback**: Make requested changes
4. **Approval**: Once approved, your PR will be merged

### After Merge

- Your branch will be deleted automatically
- Update your local repository:
  ```bash
  git checkout master
  git pull upstream master
  ```

## Code Style

### Dart Style Guide

Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide.

### Formatting

```bash
# Format all files
dart format .

# Format specific file
dart format lib/main.dart
```

### Key Guidelines

1. **Use meaningful names**: Variables and functions should clearly express their purpose
2. **Keep functions small**: Functions should do one thing well
3. **Add comments**: Explain "why" not "what"
4. **Use const**: Use `const` constructors when possible
5. **Avoid deep nesting**: Keep code readable

### Example

```dart
// Good
class ResistorDecoder {
  static double calculateResistance(
    List<ColorBand> bands,
    ResistorType type,
  ) {
    if (bands.isEmpty) {
      throw ArgumentError('Bands cannot be empty');
    }
    // ... calculation logic
  }
}

// Bad
class RD {
  static double calc(List<ColorBand> b, ResistorType t) {
    // ... unclear code
  }
}
```

## Testing Guidelines

### Writing Tests

- Write tests for new features
- Write tests for bug fixes
- Aim for good test coverage
- Test edge cases and error conditions

### Test Structure

```dart
void main() {
  group('ResistorDecoder', () {
    test('calculates resistance correctly for 4-band resistor', () {
      // Arrange
      final bands = [
        ColorBand.brown,
        ColorBand.black,
        ColorBand.red,
        ColorBand.gold,
      ];
      
      // Act
      final resistance = ResistorDecoder.calculateResistance(bands);
      
      // Assert
      expect(resistance, equals(1000.0));
    });
    
    test('throws error for empty bands', () {
      expect(
        () => ResistorDecoder.calculateResistance([]),
        throwsArgumentError,
      );
    });
  });
}
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/decoder_test.dart

# Run with coverage
flutter test --coverage
```

## Documentation

### Code Documentation

- Add doc comments for public APIs
- Explain complex algorithms
- Include examples where helpful

```dart
/// Calculates the resistance value from color bands.
///
/// Supports 4-band and 5-band resistors.
///
/// Throws [ArgumentError] if bands list is empty or invalid.
///
/// Example:
/// ```dart
/// final bands = [ColorBand.brown, ColorBand.black, ColorBand.red];
/// final resistance = calculateResistance(bands);
/// ```
double calculateResistance(List<ColorBand> bands) {
  // ...
}
```

### README Updates

- Update README.md for user-facing changes
- Add new features to the Features section
- Update setup instructions if needed

## Questions?

If you have questions or need help:

- Open an [issue](https://github.com/victorKariuki/Resistor-calculator/issues)
- Check existing documentation
- Ask in your pull request

Thank you for contributing! 🎉

