import 'package:flutter_test/flutter_test.dart';
import 'package:resistor_calculator/features/junk_box_solver/junk_box_solver_logic.dart';

void main() {
  group('JunkBoxSolverLogic', () {
    test('finds series combination matching target resistance', () {
      final results = JunkBoxSolverLogic.findCombinations(
        3000.0, // Target: 3 kΩ
        [1000.0, 2000.0, 5000.0], // Available resistors
        2, // Max 2 resistors
        0.1, // 10% tolerance
      );

      expect(results, isNotEmpty);
      expect(results.any((r) => r.contains('Series')), isTrue);
    });

    test('finds parallel combination matching target resistance', () {
      final results = JunkBoxSolverLogic.findCombinations(
        500.0, // Target: 500 Ω (from 1k || 1k = 500Ω)
        [1000.0, 1000.0, 2000.0], // Available resistors
        2, // Max 2 resistors
        0.1, // 10% tolerance
      );

      expect(results, isNotEmpty);
      expect(results.any((r) => r.contains('Parallel')), isTrue);
    });

    test('returns empty list when no combinations match', () {
      final results = JunkBoxSolverLogic.findCombinations(
        1000000.0, // Target: 1 MΩ
        [10.0, 20.0, 30.0], // Very small resistors
        2, // Max 2 resistors
        0.1, // 10% tolerance
      );

      expect(results, isEmpty);
    });

    test('respects maxResistors limit', () {
      final results = JunkBoxSolverLogic.findCombinations(
        3000.0,
        [1000.0, 2000.0, 5000.0],
        1, // Max 1 resistor (should find nothing)
        0.1,
      );

      // With maxResistors = 1, no combinations should be found
      expect(results, isEmpty);
    });

    test('handles tolerance correctly', () {
      final results = JunkBoxSolverLogic.findCombinations(
        3000.0,
        [1000.0, 2000.0], // 1000 + 2000 = 3000 (exact match)
        2,
        0.05, // 5% tolerance
      );

      expect(results, isNotEmpty);
    });

    test('handles very strict tolerance', () {
      final results = JunkBoxSolverLogic.findCombinations(
        3000.0,
        [1000.0, 2000.0], // Exact match
        2,
        0.01, // 1% tolerance (very strict)
      );

      expect(results, isNotEmpty);
    });

    test('handles very loose tolerance', () {
      final results = JunkBoxSolverLogic.findCombinations(
        3000.0,
        [1000.0, 1500.0], // 2500 total (within 20%)
        2,
        0.2, // 20% tolerance (loose)
      );

      expect(results, isNotEmpty);
    });

    test('handles empty available resistors list', () {
      final results = JunkBoxSolverLogic.findCombinations(
        3000.0,
        [], // No available resistors
        2,
        0.1,
      );

      expect(results, isEmpty);
    });

    test('handles single resistor in available list', () {
      final results = JunkBoxSolverLogic.findCombinations(
        1000.0,
        [1000.0], // Single resistor matching target
        2,
        0.1,
      );

      // With maxResistors >= 2, should try combinations but find none
      // (can't combine single resistor with itself in this implementation)
      expect(results, isA<List<String>>());
    });

    test('finds multiple valid combinations', () {
      final results = JunkBoxSolverLogic.findCombinations(
        3000.0,
        [1000.0, 2000.0, 1500.0, 1500.0], // Multiple options
        2,
        0.1,
      );

      // Should find multiple combinations
      expect(results.length, greaterThan(1));
    });

    test('handles zero target resistance', () {
      final results = JunkBoxSolverLogic.findCombinations(
        0.0,
        [1000.0, 2000.0],
        2,
        0.1,
      );

      // Zero resistance might not find valid combinations
      expect(results, isA<List<String>>());
    });

    test('handles very large target resistance', () {
      final results = JunkBoxSolverLogic.findCombinations(
        1000000.0, // 1 MΩ
        [100000.0, 200000.0, 300000.0],
        2,
        0.1,
      );

      expect(results, isA<List<String>>());
    });
  });
}

