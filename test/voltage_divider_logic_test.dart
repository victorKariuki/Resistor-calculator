import 'package:flutter_test/flutter_test.dart';
import 'package:resistor_calculator/features/circuit_synthesis/voltage_divider/voltage_divider_logic.dart';

void main() {
  group('VoltageDividerLogic', () {
    test('calculates R2 when R1 is provided', () {
      final result = VoltageDividerLogic.calculate(
        vin: 12.0,
        vout: 6.0,
        r1: 10000.0,
      );

      expect(result['r2'], closeTo(10000.0, 0.01));
    });

    test('calculates R1 when R2 is provided', () {
      final result = VoltageDividerLogic.calculate(
        vin: 12.0,
        vout: 6.0,
        r2: 10000.0,
      );

      expect(result['r1'], closeTo(10000.0, 0.01));
    });

    test('calculates both R1 and R2 when current is provided', () {
      final result = VoltageDividerLogic.calculate(
        vin: 12.0,
        vout: 6.0,
        current: 0.001,
      );

      expect(result['r1'], closeTo(6000.0, 0.01));
      expect(result['r2'], closeTo(6000.0, 0.01));
    });

    test('uses default total resistance when no optional parameters provided', () {
      final result = VoltageDividerLogic.calculate(
        vin: 12.0,
        vout: 6.0,
      );

      expect(result['r1'], isNotNull);
      expect(result['r2'], isNotNull);
      expect(result['r1']! + result['r2']!, closeTo(10000.0, 0.01));
    });

    test('handles zero output voltage', () {
      final result = VoltageDividerLogic.calculate(
        vin: 12.0,
        vout: 0.0,
        r1: 10000.0,
      );

      expect(result['r2'], equals(0.0));
    });

    test('handles output voltage equal to input voltage', () {
      final result = VoltageDividerLogic.calculate(
        vin: 12.0,
        vout: 12.0,
        r1: 10000.0,
      );

      // When vout = vin, R2 should be infinite (or very large)
      expect(result['r2']?.isInfinite ?? false, isTrue);
    });

    test('finds nearest standard E24 value correctly', () {
      // Test value close to 1.5 (should find 1.5)
      final nearest = VoltageDividerLogic.findNearestStandardValue(1.45);
      expect(nearest, closeTo(1.5, 0.1));

      // Test value close to 2.2 (should find 2.2)
      final nearest2 = VoltageDividerLogic.findNearestStandardValue(2.15);
      expect(nearest2, closeTo(2.2, 0.1));
    });

    test('finds nearest standard value for different magnitudes', () {
      // Test 1.5 kΩ
      final nearest1 = VoltageDividerLogic.findNearestStandardValue(1500.0);
      expect(nearest1, closeTo(1500.0, 10.0));

      // Test 2.2 MΩ
      final nearest2 = VoltageDividerLogic.findNearestStandardValue(2200000.0);
      expect(nearest2, closeTo(2200000.0, 10000.0));
    });

    test('handles very small resistance values', () {
      final nearest = VoltageDividerLogic.findNearestStandardValue(0.0015);
      expect(nearest, greaterThan(0.0));
    });

    test('handles very large resistance values', () {
      final nearest = VoltageDividerLogic.findNearestStandardValue(10000000.0);
      expect(nearest, greaterThan(0.0));
    });

    test('voltage divider calculation maintains correct ratio', () {
      final result = VoltageDividerLogic.calculate(
        vin: 10.0,
        vout: 3.0,
        r1: 7000.0,
      );

      // vout/vin = R2/(R1+R2)
      // 3/10 = R2/(7000+R2)
      // R2 should be approximately 3000
      expect(result['r2'], closeTo(3000.0, 0.01));
    });
  });
}

