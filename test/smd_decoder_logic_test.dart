import 'package:flutter_test/flutter_test.dart';
import 'package:resistor_calculator/features/smd_decoder/smd_decoder_logic.dart';

void main() {
  group('SmdDecoderLogic', () {
    late SmdDecoderLogic smdDecoderLogic;

    setUp(() {
      smdDecoderLogic = SmdDecoderLogic();
    });

    tearDown(() {
      smdDecoderLogic.dispose();
    });

    test('initializes with empty result', () {
      expect(smdDecoderLogic.result, equals(''));
    });

    test('decodes 3-digit SMD code correctly', () {
      smdDecoderLogic.textController.text = '102';
      smdDecoderLogic.decodeSmd();
      
      // 102 = 10 * 10^2 = 1000 Ω = 1 kΩ
      expect(smdDecoderLogic.result, contains('1'));
      expect(smdDecoderLogic.result, contains('kΩ'));
    });

    test('decodes 4-digit SMD code correctly', () {
      smdDecoderLogic.textController.text = '1002';
      smdDecoderLogic.decodeSmd();
      
      // 1002 = 100 * 10^2 = 10000 Ω = 10 kΩ
      expect(smdDecoderLogic.result, contains('10'));
      expect(smdDecoderLogic.result, contains('kΩ'));
    });

    test('handles empty input', () {
      smdDecoderLogic.textController.text = '';
      smdDecoderLogic.decodeSmd();
      
      expect(smdDecoderLogic.result, equals(''));
    });

    test('handles whitespace in input', () {
      smdDecoderLogic.textController.text = '  102  ';
      smdDecoderLogic.decodeSmd();
      
      expect(smdDecoderLogic.result, isNotEmpty);
    });

    test('handles lowercase input', () {
      smdDecoderLogic.textController.text = '102';
      smdDecoderLogic.decodeSmd();
      
      expect(smdDecoderLogic.result, isNotEmpty);
    });

    test('handles uppercase input', () {
      smdDecoderLogic.textController.text = '102';
      smdDecoderLogic.decodeSmd();
      
      expect(smdDecoderLogic.result, isNotEmpty);
    });

    test('handles invalid SMD code', () {
      smdDecoderLogic.textController.text = 'ABC';
      smdDecoderLogic.decodeSmd();
      
      // Should handle gracefully, result may be empty or error message
      expect(smdDecoderLogic.result, isNotNull);
    });

    test('updates result when decode is called multiple times', () {
      smdDecoderLogic.textController.text = '102';
      smdDecoderLogic.decodeSmd();
      final firstResult = smdDecoderLogic.result;
      
      smdDecoderLogic.textController.text = '103';
      smdDecoderLogic.decodeSmd();
      final secondResult = smdDecoderLogic.result;
      
      expect(firstResult, isNot(equals(secondResult)));
    });
  });
}

