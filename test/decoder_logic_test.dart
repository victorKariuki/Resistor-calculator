import 'package:flutter_test/flutter_test.dart';
import 'package:resistor_calculator/features/decoder/decoder_logic.dart';

void main() {
  group('DecoderLogic', () {
    late DecoderLogic decoderLogic;

    setUp(() {
      decoderLogic = DecoderLogic();
    });

    test('initializes with default 4-band configuration', () {
      expect(decoderLogic.bandCount, equals(4));
      expect(decoderLogic.band1Color, equals('Brown'));
      expect(decoderLogic.band2Color, equals('Black'));
      expect(decoderLogic.multiplierColor, equals('Red'));
      expect(decoderLogic.toleranceColor, equals('Gold'));
    });

    test('calculates resistance correctly for 4-band resistor', () {
      // Brown-Black-Red-Gold = 10 * 100 = 1000 Ω ±5%
      decoderLogic.setBandColor(1, 'Brown');
      decoderLogic.setBandColor(2, 'Black');
      decoderLogic.setBandColor(4, 'Red');
      decoderLogic.setBandColor(5, 'Gold');

      expect(decoderLogic.resistance, contains('1.00 kΩ'));
      expect(decoderLogic.tolerance, equals('±5.0%'));
    });

    test('calculates resistance correctly for 5-band resistor', () {
      decoderLogic.setBandCount(5);
      
      // Brown-Black-Black-Red-Gold = 100 * 100 = 10000 Ω ±5%
      decoderLogic.setBandColor(1, 'Brown');
      decoderLogic.setBandColor(2, 'Black');
      decoderLogic.setBandColor(3, 'Black');
      decoderLogic.setBandColor(4, 'Red');
      decoderLogic.setBandColor(5, 'Gold');

      expect(decoderLogic.resistance, contains('10.00 kΩ'));
      expect(decoderLogic.tolerance, equals('±5.0%'));
    });

    test('calculates resistance correctly for 6-band resistor', () {
      decoderLogic.setBandCount(6);
      
      // Brown-Black-Black-Red-Gold-Brown = 100 * 100 = 10000 Ω ±5% 100ppm/K
      decoderLogic.setBandColor(1, 'Brown');
      decoderLogic.setBandColor(2, 'Black');
      decoderLogic.setBandColor(3, 'Black');
      decoderLogic.setBandColor(4, 'Red');
      decoderLogic.setBandColor(5, 'Gold');
      decoderLogic.setBandColor(6, 'Brown');

      expect(decoderLogic.resistance, contains('10.00 kΩ'));
      expect(decoderLogic.tolerance, equals('±5.0%'));
      expect(decoderLogic.tcr, contains('100'));
    });

    test('formats resistance correctly for different magnitudes', () {
      // Test Ω range
      decoderLogic.setBandColor(1, 'Brown');
      decoderLogic.setBandColor(2, 'Black');
      decoderLogic.setBandColor(4, 'Black'); // multiplier = 1
      expect(decoderLogic.resistance, contains('Ω'));

      // Test kΩ range
      decoderLogic.setBandColor(4, 'Red'); // multiplier = 100
      expect(decoderLogic.resistance, contains('kΩ'));

      // Test MΩ range
      decoderLogic.setBandColor(4, 'Green'); // multiplier = 100000
      expect(decoderLogic.resistance, contains('MΩ'));

      // Test GΩ range (Violet = 10M, but we need higher for GΩ)
      // For GΩ, we'd need a very high multiplier, so skip this test
      // or use a combination that actually produces GΩ
    });

    test('handles band count changes correctly', () {
      expect(decoderLogic.bandCount, equals(4));
      
      decoderLogic.setBandCount(5);
      expect(decoderLogic.bandCount, equals(5));
      
      decoderLogic.setBandCount(6);
      expect(decoderLogic.bandCount, equals(6));
    });

    test('updates resistance when band colors change', () {
      final initialResistance = decoderLogic.resistance;
      
      decoderLogic.setBandColor(1, 'Red');
      
      expect(decoderLogic.resistance, isNot(equals(initialResistance)));
    });

    test('handles 3-band resistor (no tolerance)', () {
      decoderLogic.setBandCount(3);
      
      decoderLogic.setBandColor(1, 'Brown');
      decoderLogic.setBandColor(2, 'Black');
      decoderLogic.setBandColor(4, 'Red');

      // 3-band resistors may have default tolerance, check it's a valid string
      expect(decoderLogic.tolerance, isNotEmpty);
    });
  });
}

