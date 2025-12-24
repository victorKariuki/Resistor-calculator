
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryManager with ChangeNotifier {
  static const _key = 'history_resistors';
  static const _historyLimit = 20;

  List<String> _history = [];
  List<String> get history => _history;

  HistoryManager() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _history = prefs.getStringList(_key) ?? [];
    notifyListeners();
  }

  Future<void> addHistory(String calculation) async {
    _history.remove(calculation);
    _history.insert(0, calculation);

    if (_history.length > _historyLimit) {
      _history = _history.sublist(0, _historyLimit);
    }

    await _saveHistory();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _history.clear();
    await _saveHistory();
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _history);
  }
}
