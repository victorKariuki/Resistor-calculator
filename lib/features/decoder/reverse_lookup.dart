
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

    input = input.replaceAll('Ω', '').trim();
    double multiplier = 1.0;

    if (input.toUpperCase().endsWith('G')) {
      multiplier = 1e9;
      input = input.substring(0, input.length - 1);
    } else if (input.toUpperCase().endsWith('M')) {
      multiplier = 1e6;
      input = input.substring(0, input.length - 1);
    } else if (input.toUpperCase().endsWith('K')) {
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

    List<String> digits = ResistorData.digitValues.keys.toList();
    List<String> multipliers = ResistorData.multiplierValues.keys.toList();

    double bestError = double.infinity;
    ReverseLookupResult? bestResult;

    if (bandCount <= 4) {
      // 3 or 4-band
      for (String d1 in digits) {
        for (String d2 in digits) {
          for (String mult in multipliers) {
            double val = (ResistorData.digitValues[d1]! * 10 +
                    ResistorData.digitValues[d2]!) *
                ResistorData.multiplierValues[mult]!;
            double error = (val - resistance).abs();

            if (error < bestError) {
              bestError = error;
              bestResult = ReverseLookupResult(
                band1Color: d1,
                band2Color: d2,
                multiplierColor: mult,
                actualResistance: val,
              );
            }
          }
        }
      }
    } else {
      // 5 or 6-band
      for (String d1 in digits) {
        for (String d2 in digits) {
          for (String d3 in digits) {
            for (String mult in multipliers) {
              double val = (ResistorData.digitValues[d1]! * 100 +
                      ResistorData.digitValues[d2]! * 10 +
                      ResistorData.digitValues[d3]!) *
                  ResistorData.multiplierValues[mult]!;
              double error = (val - resistance).abs();

              if (error < bestError) {
                bestError = error;
                bestResult = ReverseLookupResult(
                  band1Color: d1,
                  band2Color: d2,
                  band3Color: d3,
                  multiplierColor: mult,
                  actualResistance: val,
                );
              }
            }
          }
        }
      }
    }
    return bestResult;
  }
}
