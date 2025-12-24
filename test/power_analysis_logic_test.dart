import 'package:flutter_test/flutter_test.dart';
import 'package:resistor_calculator/features/power_analysis/power_analysis_logic.dart';

void main() {
  group('PowerAnalysisLogic', () {
    test('calculates power from voltage and current', () {
      final result = PowerAnalysisLogic.calculate(
        voltage: 12.0,
        current: 0.5,
      );

      expect(result['resistance'], closeTo(24.0, 0.01));
      expect(result['power'], closeTo(6.0, 0.01));
    });

    test('calculates power from voltage and resistance', () {
      final result = PowerAnalysisLogic.calculate(
        voltage: 12.0,
        resistance: 24.0,
      );

      expect(result['current'], closeTo(0.5, 0.01));
      expect(result['power'], closeTo(6.0, 0.01));
    });

    test('calculates power from current and resistance', () {
      final result = PowerAnalysisLogic.calculate(
        current: 0.5,
        resistance: 24.0,
      );

      expect(result['voltage'], closeTo(12.0, 0.01));
      expect(result['power'], closeTo(6.0, 0.01));
    });

    test('returns empty map when insufficient parameters provided', () {
      final result = PowerAnalysisLogic.calculate(
        voltage: 12.0,
      );

      expect(result, isEmpty);
    });

    test('handles zero voltage', () {
      final result = PowerAnalysisLogic.calculate(
        voltage: 0.0,
        current: 0.5,
      );

      expect(result['resistance'], equals(0.0));
      expect(result['power'], equals(0.0));
    });

    test('handles zero current', () {
      final result = PowerAnalysisLogic.calculate(
        voltage: 12.0,
        current: 0.0,
      );

      expect(result['resistance']?.isInfinite ?? false, isTrue);
      expect(result['power'], equals(0.0));
    });

    test('calculates temperature rise correctly', () {
      final temperatureRise = PowerAnalysisLogic.calculateTemperatureRise(
        power: 1.0,
        thermalResistance: 50.0,
        ambientTemperature: 25.0,
      );

      expect(temperatureRise, equals(75.0));
    });

    test('handles zero power in temperature calculation', () {
      final temperatureRise = PowerAnalysisLogic.calculateTemperatureRise(
        power: 0.0,
        thermalResistance: 50.0,
        ambientTemperature: 25.0,
      );

      expect(temperatureRise, equals(25.0));
    });

    test('handles high power values', () {
      final result = PowerAnalysisLogic.calculate(
        voltage: 100.0,
        resistance: 10.0,
      );

      expect(result['power'], closeTo(1000.0, 0.01));
    });

    test('handles very small resistance values', () {
      final result = PowerAnalysisLogic.calculate(
        voltage: 5.0,
        resistance: 0.1,
      );

      expect(result['current'], closeTo(50.0, 0.01));
      expect(result['power'], closeTo(250.0, 0.01));
    });
  });
}

