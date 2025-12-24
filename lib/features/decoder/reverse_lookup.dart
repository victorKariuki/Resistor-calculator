import 'dart:math';

import 'resistor_data.dart';

class ReverseLookupResult {
  final String band1Color;
  final String band2Color;
  final String? band3Color;
  final String multiplierColor;
  final double actualResistance;

  ReverseLookupResult({
    required this.band1Color,
    required this.band2Color,
    this.band3Color,
    required this.multiplierColor,
    required this.actualResistance,
  });
}

class ReverseLookup {
  static double? parseResistance(String input) {
    if (input.isEmpty) return null;

    input = input.replaceAll('Ω', '').trim().toUpperCase();

    if (input.contains('R')) {
      input = input.replaceAll('R', '.');
    }

    double multiplier = 1.0;

    if (input.endsWith('G')) {
      multiplier = 1e9;
      input = input.substring(0, input.length - 1);
    } else if (input.endsWith('M')) {
      multiplier = 1e6;
      input = input.substring(0, input.length - 1);
    } else if (input.endsWith('K')) {
      multiplier = 1e3;
      input = input.substring(0, input.length - 1);
    }

    try {
      return double.parse(input) * multiplier;
    } catch (e) {
      return null;
    }
  }

  static ReverseLookupResult? findBands(double resistance, int bandCount) {
    if (resistance <= 0) return null;

    String resistanceStr = resistance.toStringAsExponential(9);
    final parts = resistanceStr.split('e+');
    final significantDigits = parts[0]
        .replaceAll('.', '')
        .substring(0, bandCount <= 4 ? 2 : 3);
    final exponent = int.parse(parts[1]);

    String band1Color = ResistorData.digitValues.keys.firstWhere(
      (k) => ResistorData.digitValues[k] == int.parse(significantDigits[0]),
    );
    String band2Color = ResistorData.digitValues.keys.firstWhere(
      (k) => ResistorData.digitValues[k] == int.parse(significantDigits[1]),
    );
    String? band3Color;
    if (bandCount >= 5) {
      band3Color = ResistorData.digitValues.keys.firstWhere(
        (k) => ResistorData.digitValues[k] == int.parse(significantDigits[2]),
      );
    }

    final multiplierValue = pow(10, exponent - (bandCount <= 4 ? 1 : 2));
    String multiplierColor = ResistorData.multiplierValues.keys.firstWhere(
      (k) => ResistorData.multiplierValues[k] == multiplierValue,
      orElse: () => 'Black',
    );

    final actualResistance =
        (bandCount <= 4
            ? (int.parse(significantDigits[0]) * 10 +
                  int.parse(significantDigits[1]))
            : (int.parse(significantDigits[0]) * 100 +
                  int.parse(significantDigits[1]) * 10 +
                  int.parse(significantDigits[2]))) *
        multiplierValue.toDouble();

    return ReverseLookupResult(
      band1Color: band1Color,
      band2Color: band2Color,
      band3Color: band3Color,
      multiplierColor: multiplierColor,
      actualResistance: actualResistance,
    );
  }
}
