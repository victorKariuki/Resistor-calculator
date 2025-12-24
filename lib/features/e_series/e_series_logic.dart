import 'dart:math';
import 'package:flutter/material.dart';
import 'package:resistor_calculator/features/e_series/e_series_data.dart';

class ESeriesLogic with ChangeNotifier {
  final _resistanceController = TextEditingController();
  ESeries _selectedSeries = ESeries.e24;
  String _validationResult = '';
  String _nearestValue = '';

  TextEditingController get resistanceController => _resistanceController;
  ESeries get selectedSeries => _selectedSeries;
  String get validationResult => _validationResult;
  String get nearestValue => _nearestValue;

  void setSelectedSeries(ESeries series) {
    _selectedSeries = series;
    notifyListeners();
  }

  void validateAndQuantize() {
    final resistance = double.tryParse(_resistanceController.text);
    if (resistance == null) {
      _validationResult = 'Invalid Input';
      _nearestValue = '';
      notifyListeners();
      return;
    }

    final isStandard = _isStandardValue(resistance, _selectedSeries);
    _validationResult = isStandard ? 'Standard Value' : 'Non-Standard Value';

    if (!isStandard) {
      final nearest = _findNearestStandardValue(resistance, _selectedSeries);
      _nearestValue = 'Nearest: ${_formatResistance(nearest)}';
    } else {
      _nearestValue = '';
    }
    notifyListeners();
  }

  bool _isStandardValue(double resistance, ESeries series) {
    final seriesValues = ESeriesData.values[series]!;
    final magnitude = pow(10, (log10(resistance)).floor());
    final normalizedResistance = (resistance / magnitude).round();

    return seriesValues.contains(normalizedResistance);
  }

  double _findNearestStandardValue(double resistance, ESeries series) {
    final seriesValues = ESeriesData.values[series]!;
    final magnitude = pow(10, (log10(resistance)).floor());
    final normalizedResistance = resistance / magnitude;

    final nearestNormalized = seriesValues.reduce(
      (a, b) =>
          (a - normalizedResistance).abs() < (b - normalizedResistance).abs()
              ? a
              : b,
    );

    return (nearestNormalized * magnitude).toDouble();
  }

  String _formatResistance(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(2)} GΩ';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)} MΩ';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)} kΩ';
    } else {
      return '${value.toStringAsFixed(2)} Ω';
    }
  }

  double log10(num x) => log(x) / log(10);

  @override
  void dispose() {
    _resistanceController.dispose();
    super.dispose();
  }
}
