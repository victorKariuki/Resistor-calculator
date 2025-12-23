import 'dart:math';

class PowerAnalysisLogic {
  static Map<String, double> calculate({
    double? voltage,
    double? current,
    double? resistance,
  }) {
    if (voltage != null && current != null) {
      final r = voltage / current;
      final p = voltage * current;
      return {'resistance': r, 'power': p};
    }
    if (voltage != null && resistance != null) {
      final i = voltage / resistance;
      final p = pow(voltage, 2) / resistance;
      return {'current': i, 'power': p};
    }
    if (current != null && resistance != null) {
      final v = current * resistance;
      final p = pow(current, 2) * resistance;
      return {'voltage': v, 'power': p};
    }
    return {};
  }

  static double calculateTemperatureRise({
    required double power,
    required double thermalResistance,
    required double ambientTemperature,
  }) {
    return ambientTemperature + (power * thermalResistance);
  }
}
