import 'dart:math';

class SmdDecoderLogic {
  static final Map<String, int> _eia96CodeMap = {
    '01': 100, '02': 102, '03': 105, '04': 107, '05': 110, '06': 113, '07': 115, '08': 118, '09': 121, '10': 124,
    '11': 127, '12': 130, '13': 133, '14': 137, '15': 140, '16': 143, '17': 147, '18': 150, '19': 154, '20': 158,
    '21': 162, '22': 165, '23': 169, '24': 174, '25': 178, '26': 182, '27': 187, '28': 191, '29': 196, '30': 200,
    '31': 205, '32': 210, '33': 215, '34': 221, '35': 226, '36': 232, '37': 237, '38': 243, '39': 249, '40': 255,
    '41': 261, '42': 267, '43': 274, '44': 280, '45': 287, '46': 294, '47': 301, '48': 309, '49': 316, '50': 324,
    '51': 332, '52': 340, '53': 348, '54': 357, '55': 365, '56': 374, '57': 383, '58': 392, '59': 402, '60': 412,
    '61': 422, '62': 432, '63': 442, '64': 453, '65': 464, '66': 475, '67': 487, '68': 499, '69': 511, '70': 523,
    '71': 536, '72': 549, '73': 562, '74': 576, '75': 590, '76': 604, '77': 619, '78': 634, '79': 649, '80': 665,
    '81': 681, '82': 698, '83': 715, '84': 732, '85': 750, '86': 768, '87': 787, '88': 806, '89': 825, '90': 845,
    '91': 866, '92': 887, '93': 909, '94': 931, '95': 953, '96': 976
  };

  static final Map<String, double> _eia96MultiplierMap = {
    'Z': 0.001, 'Y': 0.01, 'X': 0.1, 'A': 1, 'B': 10, 'C': 100, 'D': 1000, 'E': 10000, 'F': 100000
  };

  static String? decode(String code) {
    code = code.trim().toUpperCase();
    if (code.isEmpty) return null;

    // EIA-96 system
    if (code.length == 3 &&
        _eia96CodeMap.containsKey(code.substring(0, 2)) &&
        _eia96MultiplierMap.containsKey(code.substring(2, 3))) {
      final int valueCode = _eia96CodeMap[code.substring(0, 2)]!;
      final double multiplier = _eia96MultiplierMap[code.substring(2, 3)]!;
      return _formatResistance(valueCode * multiplier);
    }

    // Standard 3 or 4-digit system
    if (RegExp(r'^[0-9]+R?[0-9]*$').hasMatch(code)) {
      if (code.contains('R')) {
        final parts = code.split('R');
        if (parts.length == 2) {
          return _formatResistance(double.parse('${parts[0]}.${parts[1]}'));
        }
      } else {
        if (code.length == 3) {
          final int d1 = int.parse(code.substring(0, 1));
          final int d2 = int.parse(code.substring(1, 2));
          final int m = int.parse(code.substring(2, 3));
          return _formatResistance((d1 * 10 + d2) * pow(10, m).toDouble());
        } else if (code.length == 4) {
          final int d1 = int.parse(code.substring(0, 1));
          final int d2 = int.parse(code.substring(1, 2));
          final int d3 = int.parse(code.substring(2, 3));
          final int m = int.parse(code.substring(3, 4));
          return _formatResistance((d1 * 100 + d2 * 10 + d3) * pow(10, m).toDouble());
        }
      }
    }

    return null; // Invalid code
  }

  static String _formatResistance(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(2)} GΩ';
    }
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)} MΩ';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)} kΩ';
    }
    return '${value.toStringAsFixed(2)} Ω';
  }
}
