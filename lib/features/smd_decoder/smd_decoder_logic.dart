import 'package:flutter/material.dart';
import 'package:resistor_calculator/features/smd_decoder/smd_codes.dart';

class SmdDecoderLogic with ChangeNotifier {
  final _textController = TextEditingController();
  String _result = '';

  TextEditingController get textController => _textController;
  String get result => _result;

  void decodeSmd() {
    final code = _textController.text.trim().toUpperCase();
    if (code.isEmpty) {
      _result = '';
      notifyListeners();
      return;
    }

    _result = SmdCodes.decode(code);
    notifyListeners();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
