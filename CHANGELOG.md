# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- GitHub Pages deployment workflow
- Comprehensive badges to README
- CHANGELOG.md for version history tracking
- CODEOWNERS file for code review assignments
- Unit tests for core business logic modules
- Unified AppBarBack widget for consistent navigation across all pages

### Changed
- Updated dependencies to latest compatible versions
- Improved decoder logic implementation
- Unified UI/UX: Added back navigation buttons to all pages (Settings, About, and all calculator sub-pages)
- Consistent AppBar styling across all views using AppBarBack widget

### Fixed
- Fixed navigation error when pressing back button on Settings/About pages by using GoRouter's context.pop() instead of Navigator.pop()

## [1.0.0] - 2025-12-24

### Added
- Initial release of Resistor Calculator
- Resistor Color Code Calculator with support for 4-band, 5-band, and 6-band resistors
- SMD Resistor Decoder supporting 3-digit, 4-digit, and EIA-96 codes
- E-Series Finder for standard resistor values (E6, E12, E24, E48, E96, E192)
- Junk Box Solver to find resistor combinations from available parts
- Power Analysis calculator for power dissipation calculations
- Voltage Divider Calculator
- L-Match Impedance Matching calculator
- Favorites feature to save favorite resistor values
- History feature to track calculation history
- Dark/Light theme support
- Cross-platform support (Android, iOS, Web)
- Comprehensive documentation (README, CONTRIBUTING, CODE_OF_CONDUCT, SECURITY)
- CI/CD workflows for automated testing and building
- Issue and Pull Request templates

### Security
- Apache 2.0 License
- Security policy and reporting guidelines
- Input validation and sanitization

[Unreleased]: https://github.com/victorKariuki/Resistor-calculator/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/victorKariuki/Resistor-calculator/releases/tag/v1.0.0

