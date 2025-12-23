import 'package:flutter/material.dart';
import 'e_series_data.dart';
import 'e_series_logic.dart';

class ESeriesView extends StatefulWidget {
  const ESeriesView({super.key});

  @override
  State<ESeriesView> createState() => _ESeriesViewState();
}

class _ESeriesViewState extends State<ESeriesView> {
  final _resistanceController = TextEditingController();
  ESeries _selectedSeries = ESeries.e24;
  String _validationResult = '';
  String _nearestValue = '';

  void _validateAndQuantize() {
    final resistance = double.tryParse(_resistanceController.text);
    if (resistance == null) {
      setState(() {
        _validationResult = 'Invalid Input';
        _nearestValue = '';
      });
      return;
    }

    final isStandard = ESeriesLogic.isStandardValue(resistance, _selectedSeries);
    setState(() {
      _validationResult = isStandard ? 'Standard Value' : 'Non-Standard Value';
    });

    if (!isStandard) {
      final nearestValue = ESeriesLogic.findNearestStandardValue(resistance, _selectedSeries);
      setState(() {
        _nearestValue = 'Nearest: ${nearestValue.toStringAsFixed(2)} Ω';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('E-Series Validator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _resistanceController,
              decoration: const InputDecoration(
                labelText: 'Enter Resistance (Ω)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            DropdownButton<ESeries>(
              value: _selectedSeries,
              onChanged: (ESeries? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedSeries = newValue;
                  });
                }
              },
              items: ESeries.values.map((ESeries series) {
                return DropdownMenuItem<ESeries>(
                  value: series,
                  child: Text(series.toString().split('.').last.toUpperCase()),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateAndQuantize,
              child: const Text('Validate & Quantize'),
            ),
            const SizedBox(height: 30),
            if (_validationResult.isNotEmpty)
              Text(
                _validationResult,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: _validationResult == 'Standard Value'
                          ? Colors.green
                          : Colors.orange,
                    ),
                textAlign: TextAlign.center,
              ),
            if (_nearestValue.isNotEmpty)
              Text(
                _nearestValue,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
