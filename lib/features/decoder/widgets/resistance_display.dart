import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resistor_calculator/features/decoder/decoder_logic.dart';
import 'package:resistor_calculator/features/favorites/favorites_manager.dart';

class ResistanceDisplay extends StatelessWidget {
  const ResistanceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<DecoderLogic>(context);
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Resistance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              '${logic.resistance} ${logic.tolerance}',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (logic.tcr.isNotEmpty) ...[
              const SizedBox(height: 5),
              Text(
                'TCR: ${logic.tcr}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                if (logic.resistance.isNotEmpty) {
                  final valueToSave = '${logic.resistance} ${logic.tolerance}${logic.tcr.isNotEmpty ? ' ${logic.tcr}' : ''}';
                  Provider.of<FavoritesManager>(context, listen: false).addFavorite(valueToSave);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saved "$valueToSave" to favorites.'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.favorite_border),
              label: const Text('Save to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
