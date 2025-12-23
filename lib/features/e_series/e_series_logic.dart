import 'dart:math';

import 'e_series_data.dart';

class ESeriesLogic {
  static bool isStandardValue(double resistance, ESeries series) {
    final seriesValues = ESeriesData.values[series]!;
    final magnitude = pow(10, (log(resistance) / log(10)).floor());
    final normalizedResistance = (resistance / magnitude).round();

    return seriesValues.contains(normalizedResistance);
  }

  static double findNearestStandardValue(double resistance, ESeries series) {
    final seriesValues = ESeriesData.values[series]!;
    final magnitude = pow(10, (log(resistance) / log(10)).floor());
    final normalizedResistance = resistance / magnitude;

    final nearestNormalized = seriesValues.reduce((a, b) =>
        (a - normalizedResistance).abs() < (b - normalizedResistance).abs()
            ? a
            : b);

    return (nearestNormalized * magnitude).toDouble();
  }
}
