class JunkBoxSolverLogic {
  static List<String> findCombinations(
    double targetResistance,
    List<double> availableResistors,
    int maxResistors,
    double tolerance,
  ) {
    final List<String> results = [];

    // Series combinations
    for (int i = 0; i < availableResistors.length; i++) {
      for (int j = i; j < availableResistors.length; j++) {
        if (maxResistors >= 2) {
          final r1 = availableResistors[i];
          final r2 = availableResistors[j];
          final seriesResistance = r1 + r2;
          if ((seriesResistance - targetResistance).abs() / targetResistance <=
              tolerance) {
            results.add(
              '$r1 Ω + $r2 Ω = ${seriesResistance.toStringAsFixed(2)} Ω (Series)',
            );
          }
        }

        // Parallel combinations
        if (maxResistors >= 2) {
          final r1 = availableResistors[i];
          final r2 = availableResistors[j];
          final parallelResistance = (r1 * r2) / (r1 + r2);
          if ((parallelResistance - targetResistance).abs() /
                  targetResistance <=
              tolerance) {
            results.add(
              '$r1 Ω || $r2 Ω = ${parallelResistance.toStringAsFixed(2)} Ω (Parallel)',
            );
          }
        }
      }
    }

    return results;
  }
}
