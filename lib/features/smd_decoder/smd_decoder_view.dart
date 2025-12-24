import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resistor_calculator/features/favorites/favorites_manager.dart';
import 'package:resistor_calculator/features/history/history_manager.dart';
import 'package:resistor_calculator/features/smd_decoder/smd_decoder_logic.dart';

class SmdDecoderView extends StatelessWidget {
  const SmdDecoderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SmdDecoderLogic(),
      child: Consumer<SmdDecoderLogic>(
        builder: (context, logic, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('SMD Resistor Decoder')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: logic.textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter SMD Code',
                      border: OutlineInputBorder(),
                      hintText: 'e.g., 103, 4R7, 01C',
                    ),
                    onChanged: (value) => logic.decodeSmd(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: logic.decodeSmd, child: const Text('Decode')),
                  const SizedBox(height: 20),
                  if (logic.result.isNotEmpty)
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Result',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              logic.result,
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                Provider.of<FavoritesManager>(context, listen: false).addFavorite('SMD: ${logic.result}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Saved to favorites.'),
                                  ),
                                );
                                Provider.of<HistoryManager>(context, listen: false).addHistory('SMD: ${logic.textController.text} -> ${logic.result}');
                              },
                              icon: const Icon(Icons.favorite_border),
                              label: const Text('Save to Favorites'),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
