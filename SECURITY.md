# Security Policy

## Supported Versions

We actively support security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

### How to Report

We take security vulnerabilities seriously. If you discover a security vulnerability, please report it through one of the following methods:

1. **GitHub Security Advisory** (Preferred):
   - Navigate to the [Security tab](https://github.com/victorKariuki/Resistor-calculator/security)
   - Click "Report a vulnerability"
   - Fill out the security advisory form

2. **Email** (If GitHub Security Advisory is not available):
   - Contact the repository maintainer via their GitHub profile
   - Include detailed information about the vulnerability

### What to Include

When reporting a vulnerability, please include:

- **Description**: Clear description of the vulnerability
- **Impact**: Potential impact if exploited
- **Steps to Reproduce**: Detailed steps to reproduce the issue
- **Suggested Fix**: If you have ideas for fixing it (optional)
- **Affected Versions**: Which versions are affected

### Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Resolution**: Depends on severity and complexity

### Disclosure Policy

- We will acknowledge receipt of your report within 48 hours
- We will keep you informed of our progress
- We will notify you when the vulnerability is fixed
- We will credit you in the security advisory (if you wish)

## Security Best Practices

### For Users

1. **Keep the app updated**: Always use the latest version
2. **Review permissions**: Only grant necessary permissions
3. **Report issues**: If you find a security issue, report it responsibly
4. **Use official sources**: Only download from official app stores or GitHub releases

### For Contributors

#### Code Security Guidelines

1. **Never commit secrets**:
   - API keys
   - Passwords
   - Tokens
   - Private keys
   - Any sensitive credentials

2. **Validate all inputs**:
   ```dart
   // Good
   if (input == null || input.isEmpty) {
     throw ArgumentError('Input cannot be empty');
   }
   
   // Validate format
   if (!RegExp(r'^\d+$').hasMatch(input)) {
     throw FormatException('Invalid format');
   }
   ```

3. **Use secure storage**:
   - Use `shared_preferences` for non-sensitive data
   - Use `flutter_secure_storage` for sensitive data
   - Never store passwords or tokens in plain text

4. **Sanitize user input**:
   ```dart
   // Sanitize before processing
   String sanitizeInput(String input) {
     return input.trim().replaceAll(RegExp(r'[<>]'), '');
   }
   ```

5. **Handle errors securely**:
   ```dart
   // Don't expose internal details
   try {
     // ... operation
   } catch (e) {
     // Log internally, show generic message to user
     logger.error('Operation failed', error: e);
     throw UserFacingException('An error occurred. Please try again.');
   }
   ```

6. **Use HTTPS**:
   - All network requests must use HTTPS
   - Never make HTTP requests for sensitive data

7. **Review dependencies**:
   - Only use trusted packages from pub.dev
   - Regularly update dependencies
   - Check for known vulnerabilities

#### Security Checklist for PRs

Before submitting a PR, ensure:

- [ ] No secrets or credentials in code
- [ ] All user inputs are validated
- [ ] Error messages don't expose sensitive information
- [ ] Dependencies are from trusted sources
- [ ] Network requests use HTTPS
- [ ] Sensitive data is stored securely
- [ ] Permissions are requested only when necessary
- [ ] Code follows security best practices

### Dependency Security

#### Checking for Vulnerabilities

```bash
# Check for outdated packages
flutter pub outdated

# Update dependencies
flutter pub upgrade

# Review dependency tree
flutter pub deps
```

#### Regular Updates

- Review dependencies monthly
- Update to latest stable versions
- Test thoroughly after updates
- Check for security advisories

### Secure Storage

#### Non-Sensitive Data

```dart
// Use shared_preferences for non-sensitive data
final prefs = await SharedPreferences.getInstance();
await prefs.setString('theme', 'dark');
```

#### Sensitive Data

```dart
// Use flutter_secure_storage for sensitive data
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
await storage.write(key: 'api_token', value: token);
```

### Input Validation

Always validate and sanitize user inputs:

```dart
class InputValidator {
  static String? validateResistance(String? input) {
    if (input == null || input.isEmpty) {
      return 'Resistance value is required';
    }
    
    // Check format
    if (!RegExp(r'^\d+(\.\d+)?\s*(Ω|ohm|k|K|M)?$').hasMatch(input)) {
      return 'Invalid resistance format';
    }
    
    // Check range
    final value = double.tryParse(input);
    if (value == null || value <= 0 || value > 1e12) {
      return 'Resistance must be between 0 and 1TΩ';
    }
    
    return null; // Valid
  }
}
```

## Known Security Considerations

### Current Security Measures

1. **No Network Requests**: The app operates entirely offline
2. **Local Storage Only**: All data is stored locally on the device
3. **No External APIs**: No external API calls that could expose data
4. **Input Validation**: All user inputs are validated before processing

### Areas of Focus

- Input validation and sanitization
- Secure local storage practices
- Dependency security
- Code review for security issues

## Security Updates

Security updates will be released as:

- **Patch versions** (1.0.x) for security fixes
- **Security advisories** on GitHub
- **Release notes** documenting the fix

## Credits

We appreciate responsible disclosure and will credit security researchers who help improve the security of this project.

## Additional Resources

- [OWASP Mobile Security](https://owasp.org/www-project-mobile-security/)
- [Flutter Security Best Practices](https://docs.flutter.dev/security)
- [Dart Security](https://dart.dev/guides/libraries/security)

## Contact

For security-related questions or concerns:

- Use GitHub Security Advisory (preferred)
- Contact repository maintainer via GitHub profile
- Open a private discussion if needed

Thank you for helping keep Resistor Calculator secure! 🔒

