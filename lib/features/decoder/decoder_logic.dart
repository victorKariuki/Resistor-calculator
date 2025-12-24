import 'package:flutter/material.dart';
import 'package:resistor_calculator/features/decoder/resistor_data.dart';
import 'package:resistor_calculator/features/decoder/reverse_lookup.dart';

class DecoderLogic with ChangeNotifier {
  int _bandCount = 4;
  String _band1Color = 'Brown';
  String _band2Color = 'Black';
  String _band3Color = 'Black';
  String _multiplierColor = 'Red';
  String _toleranceColor = 'Gold';
  String _tcrColor = 'Brown';

  String _resistance = '';
  String _tolerance = '';
  String _tcr = '';

  int get bandCount => _bandCount;
  String get band1Color => _band1Color;
  String get band2Color => _band2Color;
  String get band3Color => _band3Color;
  String get multiplierColor => _multiplierColor;
  String get toleranceColor => _toleranceColor;
  String get tcrColor => _tcrColor;
  String get resistance => _resistance;
  String get tolerance => _tolerance;
  String get tcr => _tcr;

  DecoderLogic() {
    calculateResistance();
  }

  void setBandCount(int count) {
    _bandCount = count;
    calculateResistance();
  }

  void setBandColor(int band, String color) {
    switch (band) {
      case 1:
        _band1Color = color;
        break;
      case 2:
        _band2Color = color;
        break;
      case 3:
        _band3Color = color;
        break;
      case 4:
        _multiplierColor = color;
        break;
      case 5:
        _toleranceColor = color;
        break;
      case 6:
        _tcrColor = color;
        break;
    }
    calculateResistance();
  }

  void calculateResistance() {
    int digit1 = ResistorData.digitValues[_band1Color]!;
    int digit2 = ResistorData.digitValues[_band2Color]!;
    int digit3 = _bandCount >= 5 ? ResistorData.digitValues[_band3Color]! : 0;
    double multiplier = ResistorData.multiplierValues[_multiplierColor]!;
    double toleranceValue = _bandCount == 3
        ? ResistorData.toleranceValues['None']!
        : ResistorData.toleranceValues[_toleranceColor]!;
    int? tcrValue = _bandCount == 6 ? ResistorData.tcrValues[_tcrColor] : null;

    double resistanceValue;
    if (_bandCount >= 5) {
      resistanceValue = (digit1 * 100 + digit2 * 10 + digit3) * multiplier;
    } else {
      resistanceValue = (digit1 * 10 + digit2) * multiplier;
    }

    _resistance = _formatResistance(resistanceValue);
    _tolerance = '±$toleranceValue%';
    _tcr = tcrValue != null ? '$tcrValue ppm/K' : '';

    notifyListeners();
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

  ReverseLookupResult? performReverseLookup(String resistanceString) {
    final double? resistance = ReverseLookup.parseResistance(resistanceString);
    if (resistance == null) {
      return null;
    }

    final ReverseLookupResult? result = ReverseLookup.findBands(resistance, _bandCount);
    if (result != null) {
      _band1Color = result.band1Color;
      _band2Color = result.band2Color;
      if (_bandCount >= 5) {
        _band3Color = result.band3Color!;
      }
      _multiplierColor = result.multiplierColor;
      calculateResistance();
    }
    return result;
  }

  List<Color> getBandColors() {
    List<Color> colors = [];
    colors.add(ResistorData.colorMap[_band1Color]!);
    colors.add(ResistorData.colorMap[_band2Color]!);
    if (_bandCount >= 5) {
      colors.add(ResistorData.colorMap[_band3Color]!);
    }
    colors.add(ResistorData.colorMap[_multiplierColor]!);
    if (_bandCount > 3) {
      colors.add(ResistorData.colorMap[_toleranceColor]!);
    }
    if (_bandCount == 6) {
      colors.add(ResistorData.colorMap[_tcrColor]!);
    }
    return colors;
  }
}
