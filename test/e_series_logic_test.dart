import 'package:flutter_test/flutter_test.dart';
import 'package:resistor_calculator/features/e_series/e_series_logic.dart';
import 'package:resistor_calculator/features/e_series/e_series_data.dart';

void main() {
  group('ESeriesLogic', () {
    late ESeriesLogic eSeriesLogic;

    setUp(() {
      eSeriesLogic = ESeriesLogic();
    });

    tearDown(() {
      eSeriesLogic.dispose();
    });

    test('initializes with default E24 series', () {
      expect(eSeriesLogic.selectedSeries, equals(ESeries.e24));
      expect(eSeriesLogic.validationResult, equals(''));
      expect(eSeriesLogic.nearestValue, equals(''));
    });

    test('validates standard E24 value correctly', () {
      eSeriesLogic.resistanceController.text = '1000';
      eSeriesLogic.validateAndQuantize();

      expect(eSeriesLogic.validationResult, equals('Standard Value'));
    });

    test('identifies non-standard value and finds nearest', () {
      eSeriesLogic.resistanceController.text = '1234'; // Non-standard
      eSeriesLogic.validateAndQuantize();

      expect(eSeriesLogic.validationResult, equals('Non-Standard Value'));
      expect(eSeriesLogic.nearestValue, isNotEmpty);
      expect(eSeriesLogic.nearestValue, contains('Nearest:'));
    });

    test('handles invalid input', () {
      eSeriesLogic.resistanceController.text = 'abc';
      eSeriesLogic.validateAndQuantize();

      expect(eSeriesLogic.validationResult, equals('Invalid Input'));
      expect(eSeriesLogic.nearestValue, equals(''));
    });

    test('handles empty input', () {
      eSeriesLogic.resistanceController.text = '';
      eSeriesLogic.validateAndQuantize();

      expect(eSeriesLogic.validationResult, equals('Invalid Input'));
    });

    test('changes selected series correctly', () {
      eSeriesLogic.setSelectedSeries(ESeries.e12);
      expect(eSeriesLogic.selectedSeries, equals(ESeries.e12));

      eSeriesLogic.setSelectedSeries(ESeries.e96);
      expect(eSeriesLogic.selectedSeries, equals(ESeries.e96));
    });

    test('validates standard E12 value', () {
      eSeriesLogic.setSelectedSeries(ESeries.e12);
      eSeriesLogic.resistanceController.text = '1000';
      eSeriesLogic.validateAndQuantize();

      expect(eSeriesLogic.validationResult, equals('Standard Value'));
    });

    test('validates standard E6 value', () {
      eSeriesLogic.setSelectedSeries(ESeries.e6);
      eSeriesLogic.resistanceController.text = '1000';
      eSeriesLogic.validateAndQuantize();

      expect(eSeriesLogic.validationResult, equals('Standard Value'));
    });

    test('finds nearest value for different magnitudes', () {
      // Test 1 kΩ range
      eSeriesLogic.resistanceController.text = '1234';
      eSeriesLogic.validateAndQuantize();
      expect(eSeriesLogic.nearestValue, contains('kΩ'));

      // Test 1 MΩ range
      eSeriesLogic.resistanceController.text = '1234000';
      eSeriesLogic.validateAndQuantize();
      expect(eSeriesLogic.nearestValue, contains('MΩ'));
    });

    test('handles very small resistance values', () {
      eSeriesLogic.resistanceController.text = '0.1';
      eSeriesLogic.validateAndQuantize();

      expect(eSeriesLogic.validationResult, isNotEmpty);
    });

    test('handles very large resistance values', () {
      eSeriesLogic.resistanceController.text = '1000000000';
      eSeriesLogic.validateAndQuantize();

      // May or may not contain GΩ depending on formatting
      expect(eSeriesLogic.nearestValue, isNotEmpty);
    });

    test('handles decimal input', () {
      eSeriesLogic.resistanceController.text = '1234.56';
      eSeriesLogic.validateAndQuantize();

      expect(eSeriesLogic.validationResult, isNotEmpty);
    });

    test('works with different E-series', () {
      for (final series in ESeries.values) {
        eSeriesLogic.setSelectedSeries(series);
        eSeriesLogic.resistanceController.text = '1000';
        eSeriesLogic.validateAndQuantize();

        expect(eSeriesLogic.validationResult, isNotEmpty);
      }
    });
  });
}

