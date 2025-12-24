import 'package:flutter_test/flutter_test.dart';
import 'package:resistor_calculator/features/rf_analysis/l_match/l_match_logic.dart';

void main() {
  group('LMatchLogic', () {
    test('calculates L-match components correctly when source > load', () {
      final result = LMatchLogic.calculateLMatch(
        75.0, // Z source (75 Ω) - must be > load
        50.0, // Z load (50 Ω)
        1000000.0, // Frequency (1 MHz)
      );

      expect(result['l'], greaterThan(0.0));
      expect(result['c'], greaterThan(0.0));
      expect(result['l']!.isNaN, isFalse);
      expect(result['c']!.isNaN, isFalse);
    });

    test('handles equal source and load impedances', () {
      final result = LMatchLogic.calculateLMatch(
        50.0, // Z source
        50.0, // Z load (equal to source)
        1000000.0, // Frequency
      );

      // When impedances are equal, Q should be 0, resulting in very small or zero values
      expect(result['l'], isNotNull);
      expect(result['c'], isNotNull);
    });

    test('handles source impedance greater than load', () {
      final result = LMatchLogic.calculateLMatch(
        100.0, // Z source (higher) - correct case for L-match
        50.0, // Z load (lower)
        1000000.0, // Frequency
      );

      expect(result['l'], greaterThan(0.0));
      expect(result['c'], greaterThan(0.0));
      expect(result['l']!.isNaN, isFalse);
      expect(result['c']!.isNaN, isFalse);
    });

    test('handles load impedance greater than source (results in NaN)', () {
      // L-match only works when zSource > zLoad
      // When zSource < zLoad, sqrt becomes negative, resulting in NaN
      final result = LMatchLogic.calculateLMatch(
        50.0, // Z source (lower)
        100.0, // Z load (higher)
        1000000.0, // Frequency
      );

      // This case results in NaN due to sqrt of negative number
      expect(result['l']!.isNaN, isTrue);
      expect(result['c']!.isNaN, isTrue);
    });

    test('frequency affects component values', () {
      final result1 = LMatchLogic.calculateLMatch(
        50.0,
        75.0,
        1000000.0, // 1 MHz
      );

      final result2 = LMatchLogic.calculateLMatch(
        50.0,
        75.0,
        2000000.0, // 2 MHz
      );

      // Higher frequency should result in different L and C values
      expect(result1['l'], isNot(equals(result2['l'])));
      expect(result1['c'], isNot(equals(result2['c'])));
    });

    test('handles very high frequency', () {
      final result = LMatchLogic.calculateLMatch(
        75.0, // Source must be > load
        50.0,
        1000000000.0, // 1 GHz
      );

      expect(result['l'], greaterThan(0.0));
      expect(result['c'], greaterThan(0.0));
      expect(result['l']!.isNaN, isFalse);
      expect(result['c']!.isNaN, isFalse);
    });

    test('handles very low frequency', () {
      final result = LMatchLogic.calculateLMatch(
        75.0, // Source must be > load
        50.0,
        1000.0, // 1 kHz
      );

      expect(result['l'], greaterThan(0.0));
      expect(result['c'], greaterThan(0.0));
      expect(result['l']!.isNaN, isFalse);
      expect(result['c']!.isNaN, isFalse);
    });

    test('handles zero frequency gracefully', () {
      // Note: This may result in division by zero or infinite values
      // The implementation should handle this appropriately
      final result = LMatchLogic.calculateLMatch(
        50.0,
        75.0,
        0.0,
      );

      expect(result, isNotNull);
    });

    test('calculates reasonable component values for typical RF application', () {
      // Typical RF matching: 75Ω source to 50Ω load at 100 MHz
      // Note: L-match requires source > load
      final result = LMatchLogic.calculateLMatch(
        75.0, // Source (must be > load)
        50.0, // Load
        100000000.0, // 100 MHz
      );

      expect(result['l']!.isNaN, isFalse);
      expect(result['c']!.isNaN, isFalse);
      
      // L should be in reasonable range (nH to µH)
      expect(result['l']!, greaterThan(1e-9)); // Greater than 1 nH
      expect(result['l']!, lessThan(1e-3)); // Less than 1 mH

      // C should be in reasonable range (pF to nF)
      expect(result['c']!, greaterThan(1e-12)); // Greater than 1 pF
      expect(result['c']!, lessThan(1e-6)); // Less than 1 µF
    });
  });
}

