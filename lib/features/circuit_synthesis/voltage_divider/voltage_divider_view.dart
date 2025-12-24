import 'package:flutter/material.dart';
import './voltage_divider_logic.dart';
import 'package:resistor_calculator/widgets/app_bar_back.dart';

class VoltageDividerView extends StatefulWidget {
  const VoltageDividerView({super.key});

  @override
  State<VoltageDividerView> createState() => _VoltageDividerViewState();
}

class _VoltageDividerViewState extends State<VoltageDividerView> {
  final _vinController = TextEditingController();
  final _voutController = TextEditingController();
  final _r1Controller = TextEditingController();
  final _r2Controller = TextEditingController();
  final _currentController = TextEditingController();

  String _calculatedR1 = '';
  String _calculatedR2 = '';
  String _standardR1 = '';
  String _standardR2 = '';

  void _calculate() {
    final double? vin = double.tryParse(_vinController.text);
    final double? vout = double.tryParse(_voutController.text);
    final double? r1 = double.tryParse(_r1Controller.text);
    final double? r2 = double.tryParse(_r2Controller.text);
    final double? current = double.tryParse(_currentController.text);

    if (vin == null || vout == null) {
      // Or show a snackbar
      return;
    }

    final results = VoltageDividerLogic.calculate(
      vin: vin,
      vout: vout,
      r1: r1,
      r2: r2,
      current: current,
    );

    setState(() {
      _calculatedR1 = results.containsKey('r1')
          ? '${results['r1']!.toStringAsFixed(2)} Ω'
          : '${_r1Controller.text} Ω';
      _calculatedR2 = results.containsKey('r2')
          ? '${results['r2']!.toStringAsFixed(2)} Ω'
          : '${_r2Controller.text} Ω';

      final r1Value = results.containsKey('r1') ? results['r1']! : r1;
      final r2Value = results.containsKey('r2') ? results['r2']! : r2;

      if (r1Value != null) {
        _standardR1 =
            '${VoltageDividerLogic.findNearestStandardValue(r1Value)} Ω';
      }
      if (r2Value != null) {
        _standardR2 =
            '${VoltageDividerLogic.findNearestStandardValue(r2Value)} Ω';
      }
    });
  }

  void _clearFields() {
    _vinController.clear();
    _voutController.clear();
    _r1Controller.clear();
    _r2Controller.clear();
    _currentController.clear();
    setState(() {
      _calculatedR1 = '';
      _calculatedR2 = '';
      _standardR1 = '';
      _standardR2 = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(
        title: 'Voltage Divider',
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
                      'Enter known values',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Provide Vin, Vout, and one other value.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _vinController,
                      label: 'Input Voltage (Vin)',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _voutController,
                      label: 'Output Voltage (Vout)',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _r1Controller,
                      label: 'Resistor 1 (R1) in Ω',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _r2Controller,
                      label: 'Resistor 2 (R2) in Ω',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: _currentController,
                      label: 'Divider Current (A)',
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: _calculate,
                      child: const Text('Calculate'),
                    ),
                  ],
                ),
              ),
            ),
            if (_calculatedR1.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(top: 20),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Calculated Values',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 15),
                      Text('R1: $_calculatedR1'),
                      Text('R2: $_calculatedR2'),
                      const SizedBox(height: 20),
                      Text(
                        'Nearest E24 Standard Values',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Text('R1: $_standardR1'),
                      Text('R2: $_standardR2'),
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
  }) {
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
