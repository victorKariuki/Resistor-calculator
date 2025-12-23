import 'package:flutter/material.dart';
import 'l_match_logic.dart';

class LMatchView extends StatefulWidget {
  const LMatchView({super.key});

  @override
  State<LMatchView> createState() => _LMatchViewState();
}

class _LMatchViewState extends State<LMatchView> {
  final _zSourceController = TextEditingController();
  final _zLoadController = TextEditingController();
  final _frequencyController = TextEditingController();

  String _inductor = '';
  String _capacitor = '';

  void _calculate() {
    final double? zSource = double.tryParse(_zSourceController.text);
    final double? zLoad = double.tryParse(_zLoadController.text);
    final double? frequency = double.tryParse(_frequencyController.text);

    if (zSource == null || zLoad == null || frequency == null) {
      return;
    }

    final results = LMatchLogic.calculateLMatch(zSource, zLoad, frequency);

    setState(() {
      _inductor = '${results['l']!.toStringAsExponential(3)} H';
      _capacitor = '${results['c']!.toStringAsExponential(3)} F';
    });
  }

  void _clearFields() {
    _zSourceController.clear();
    _zLoadController.clear();
    _frequencyController.clear();
    setState(() {
      _inductor = '';
      _capacitor = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('L-Match Impedance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearFields,
            tooltip: 'Clear Fields',
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Enter Circuit Parameters', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20),
                    _buildTextField(controller: _zSourceController, label: 'Source Impedance (Zs) in Ω'),
                    const SizedBox(height: 15),
                    _buildTextField(controller: _zLoadController, label: 'Load Impedance (Zl) in Ω'),
                    const SizedBox(height: 15),
                    _buildTextField(controller: _frequencyController, label: 'Frequency (f) in Hz'),
                    const SizedBox(height: 25),
                    ElevatedButton(onPressed: _calculate, child: const Text('Calculate')),
                  ],
                ),
              ),
            ),
            if (_inductor.isNotEmpty)
            Card(
              margin: const EdgeInsets.only(top: 20),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Matching Network Values', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 15),
                    Text('Inductor (L): $_inductor'),
                    Text('Capacitor (C): $_capacitor'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
