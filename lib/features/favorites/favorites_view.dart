import 'package:flutter/material.dart';
import 'favorites_manager.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoritesManager.getFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _removeFavorite(String resistance) async {
    await FavoritesManager.removeFavorite(resistance);
    _loadFavorites();
  }

  Future<void> _clearFavorites() async {
    for (var fav in _favorites) {
      await FavoritesManager.removeFavorite(fav);
    }
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _favorites.isEmpty ? null : _clearFavorites,
            tooltip: 'Clear All Favorites',
          ),
        ],
      ),
      body: _favorites.isEmpty
          ? const Center(child: Text('You have no favorite resistors yet.'))
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final resistance = _favorites[index];
                return ListTile(
                  title: Text(resistance),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeFavorite(resistance),
                  ),
                );
              },
            ),
    );
  }
}
