import 'dart:math';

class LMatchLogic {
  static Map<String, double> calculateLMatch(double zSource, double zLoad, double frequency) {
    final q = sqrt((zSource / zLoad) - 1);
    final xl = q * zLoad;
    final xc = zSource / q;

    final l = xl / (2 * pi * frequency);
    final c = 1 / (2 * pi * frequency * xc);

    return {'l': l, 'c': c};
  }
}
