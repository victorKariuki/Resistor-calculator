
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../favorites/favorites_manager.dart';
import '../history/history_manager.dart';
import 'smd_codes.dart';

class SmdDecoderView extends StatefulWidget {
  const SmdDecoderView({super.key});

  @override
  State<SmdDecoderView> createState() => _SmdDecoderViewState();
}

class _SmdDecoderViewState extends State<SmdDecoderView> {
  final _textController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _decodeSmd() {
    final code = _textController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    final result = SmdCodes.decode(code);

    setState(() {
      _result = result;
    });

    Provider.of<HistoryManager>(context, listen: false).addHistory('SMD: $code -> $result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SMD Resistor Decoder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter SMD Code',
                border: OutlineInputBorder(),
                hintText: 'e.g., 103, 4R7, 01C',
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    _result = '';
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _decodeSmd,
              child: const Text('Decode'),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
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
                        _result,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Provider.of<FavoritesManager>(context, listen: false).addFavorite('SMD: $_result');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Saved to favorites.'),
                            ),
                          );
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
  }
}
