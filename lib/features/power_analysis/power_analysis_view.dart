import 'package:flutter/material.dart';
import './power_analysis_logic.dart';

class PowerAnalysisView extends StatefulWidget {
  const PowerAnalysisView({super.key});

  @override
  State<PowerAnalysisView> createState() => _PowerAnalysisViewState();
}

class _PowerAnalysisViewState extends State<PowerAnalysisView> {
  final _voltageController = TextEditingController();
  final _currentController = TextEditingController();
  final _resistanceController = TextEditingController();
  final _thermalResistanceController = TextEditingController();
  final _ambientTemperatureController = TextEditingController();

  String _power = '';
  String _estimatedTemperature = '';

  void _calculate() {
    final double? voltage = double.tryParse(_voltageController.text);
    final double? current = double.tryParse(_currentController.text);
    final double? resistance = double.tryParse(_resistanceController.text);

    final results = PowerAnalysisLogic.calculate(
      voltage: voltage,
      current: current,
      resistance: resistance,
    );

    setState(() {
      if (results.containsKey('resistance')) {
        _resistanceController.text = results['resistance']!.toStringAsFixed(3);
      }
      if (results.containsKey('current')) {
        _currentController.text = results['current']!.toStringAsFixed(3);
      }
      if (results.containsKey('voltage')) {
        _voltageController.text = results['voltage']!.toStringAsFixed(3);
      }
      _power = results.containsKey('power')
          ? '${results['power']!.toStringAsFixed(3)} W'
          : 'Invalid Inputs';
      _calculateTemperature(); // Recalculate temperature whenever power changes
    });
  }

  void _calculateTemperature() {
    final double? power = double.tryParse(_power.replaceAll(' W', ''));
    final double? thermalResistance = double.tryParse(
      _thermalResistanceController.text,
    );
    final double? ambientTemperature = double.tryParse(
      _ambientTemperatureController.text,
    );

    if (power != null &&
        thermalResistance != null &&
        ambientTemperature != null) {
      final temp = PowerAnalysisLogic.calculateTemperatureRise(
        power: power,
        thermalResistance: thermalResistance,
        ambientTemperature: ambientTemperature,
      );
      setState(() {
        _estimatedTemperature = '${temp.toStringAsFixed(2)} °C';
      });
    }
  }

  void _clearFields() {
    _voltageController.clear();
    _currentController.clear();
    _resistanceController.clear();
    setState(() {
      _power = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearFields,
            tooltip: 'Clear Fields',
          ),
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
                    Text(
                      "Ohm's Law & Power",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Enter any two values to calculate the others.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _voltageController,
                      label: 'Voltage (V)',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _currentController,
                      label: 'Current (A)',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _resistanceController,
                      label: 'Resistance (Ω)',
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: _calculate,
                      child: const Text('Calculate'),
                    ),
                    if (_power.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Power: $_power',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Thermal Analysis',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _thermalResistanceController,
                      label: 'Thermal Resistance (°C/W)',
                      onChanged: (_) => _calculateTemperature(),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _ambientTemperatureController,
                      label: 'Ambient Temperature (°C)',
                      onChanged: (_) => _calculateTemperature(),
                    ),
                    if (_estimatedTemperature.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Est. Component Temp: $_estimatedTemperature',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: onChanged,
    );
  }
}
