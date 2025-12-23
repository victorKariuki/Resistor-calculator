import 'package:shared_preferences/shared_preferences.dart';

class HistoryManager {
  static const _key = 'history_resistors';
  static const _historyLimit = 20;

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> addHistory(String calculation) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = await getHistory();

    // Remove the calculation if it already exists to avoid duplicates and move it to the top
    history.remove(calculation);

    // Add the new calculation to the beginning of the list
    history.insert(0, calculation);

    // Trim the list if it exceeds the limit
    if (history.length > _historyLimit) {
      history = history.sublist(0, _historyLimit);
    }

    await prefs.setStringList(_key, history);
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
