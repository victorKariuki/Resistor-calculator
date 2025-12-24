
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites_manager.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<FavoritesManager>(
        builder: (context, favoritesManager, child) {
          if (favoritesManager.favorites.isEmpty) {
            return const Center(
              child: Text('No favorites saved yet.'),
            );
          }

          return ListView.builder(
            itemCount: favoritesManager.favorites.length,
            itemBuilder: (context, index) {
              final favorite = favoritesManager.favorites[index];
              return ListTile(
                title: Text(favorite),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    favoritesManager.removeFavorite(favorite);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
