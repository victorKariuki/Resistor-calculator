import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager with ChangeNotifier {
  static const _key = 'favorite_resistors';

  List<String> _favorites = [];
  List<String> get favorites => _favorites;

  FavoritesManager() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList(_key) ?? [];
    notifyListeners();
  }

  Future<void> addFavorite(String resistance) async {
    if (!_favorites.contains(resistance)) {
      _favorites.add(resistance);
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String resistance) async {
    _favorites.remove(resistance);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _favorites);
  }
}
