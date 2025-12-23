import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  static const _key = 'favorite_resistors';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> addFavorite(String resistance) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    if (!favorites.contains(resistance)) {
      favorites.add(resistance);
      await prefs.setStringList(_key, favorites);
    }
  }

  static Future<void> removeFavorite(String resistance) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.remove(resistance);
    await prefs.setStringList(_key, favorites);
  }
}
