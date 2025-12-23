import 'dart:math';

class VoltageDividerLogic {
  // E24 series resistor values
  static const List<double> e24series = [
    1.0,
    1.1,
    1.2,
    1.3,
    1.5,
    1.6,
    1.8,
    2.0,
    2.2,
    2.4,
    2.7,
    3.0,
    3.3,
    3.6,
    3.9,
    4.3,
    4.7,
    5.1,
    5.6,
    6.2,
    6.8,
    7.5,
    8.2,
    9.1,
  ];

  static Map<String, double> calculate({
    required double vin,
    required double vout,
    double? r1,
    double? r2,
    double? current,
  }) {
    if (r1 != null) {
      final calculatedR2 = (vout * r1) / (vin - vout);
      return {'r2': calculatedR2};
    } else if (r2 != null) {
      final calculatedR1 = r2 * (vin - vout) / vout;
      return {'r1': calculatedR1};
    } else if (current != null) {
      final totalResistance = vin / current;
      final calculatedR1 = totalResistance * (1 - (vout / vin));
      final calculatedR2 = totalResistance - calculatedR1;
      return {'r1': calculatedR1, 'r2': calculatedR2};
    } else {
      // Default case if no optional value is provided, we can assume a total resistance, e.g. 10k
      final rTotal = 10000.0;
      final r1Calc = rTotal * (1 - (vout / vin));
      final r2Calc = rTotal - r1Calc;
      return {'r1': r1Calc, 'r2': r2Calc};
    }
  }

  static double findNearestStandardValue(double value) {
    final magnitude = pow(10, (log(value) / ln10).floor());
    final normalizedValue = value / magnitude;

    double closest = e24series.first;
    double minDifference = (normalizedValue - closest).abs();

    for (var standardValue in e24series) {
      final difference = (normalizedValue - standardValue).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closest = standardValue;
      }
    }

    return closest * magnitude;
  }
}
