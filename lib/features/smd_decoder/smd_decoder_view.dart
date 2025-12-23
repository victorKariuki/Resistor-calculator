import 'package:flutter/material.dart';
import '../favorites/favorites_manager.dart';
import '../history/history_manager.dart';
import 'smd_decoder_logic.dart';

class SmdDecoderView extends StatefulWidget {
  const SmdDecoderView({super.key});

  @override
  State<SmdDecoderView> createState() => _SmdDecoderViewState();
}

class _SmdDecoderViewState extends State<SmdDecoderView> {
  final _smdCodeController = TextEditingController();
  String _resistance = '';

  void _decodeSmd() {
    final String code = _smdCodeController.text;
    final String? resistance = SmdDecoderLogic.decode(code);

    setState(() {
      _resistance = resistance ?? 'Invalid Code';
    });

    if (resistance != null) {
      HistoryManager.addHistory(resistance);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SMD Decoder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _smdCodeController,
              decoration: const InputDecoration(
                labelText: 'Enter SMD Code',
                border: OutlineInputBorder(),
                helperText: 'e.g., 103, 1002, 4R7, 01C',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _decodeSmd, child: const Text('Decode')),
            const SizedBox(height: 30),
            if (_resistance.isNotEmpty && _resistance != 'Invalid Code')
              Card(
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
                        _resistance,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          FavoritesManager.addFavorite(_resistance);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Saved "$_resistance" to favorites.',
                              ),
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
            if (_resistance == 'Invalid Code')
              Text(
                'Invalid Code',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
