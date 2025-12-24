import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resistor_calculator/features/decoder/decoder_logic.dart';
import 'package:resistor_calculator/features/history/history_manager.dart';

class ReverseLookup extends StatelessWidget {
  const ReverseLookup({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<DecoderLogic>(context);
    final reverseLookupController = TextEditingController();
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Reverse Lookup',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: reverseLookupController,
              decoration: const InputDecoration(
                labelText: 'Enter Resistance (e.g., 4.7k)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final result = logic.performReverseLookup(reverseLookupController.text);
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid resistance value')));
                } else {
                  Provider.of<HistoryManager>(context, listen: false).addHistory('${logic.resistance} ${logic.tolerance}');
                }
              },
              child: const Text('Find Colors'),
            ),
          ],
        ),
      ),
    );
  }
}
