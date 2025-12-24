import 'package:flutter/material.dart';
import 'junk_box_solver_logic.dart';
import 'package:resistor_calculator/widgets/app_bar_back.dart';

class JunkBoxSolverView extends StatefulWidget {
  const JunkBoxSolverView({super.key});

  @override
  State<JunkBoxSolverView> createState() => _JunkBoxSolverViewState();
}

class _JunkBoxSolverViewState extends State<JunkBoxSolverView> {
  final _targetResistanceController = TextEditingController();
  final _availableResistorsController = TextEditingController();
  List<String> _results = [];

  void _solve() {
    final targetResistance = double.tryParse(_targetResistanceController.text);
    if (targetResistance == null) {
      // Handle error
      return;
    }

    final availableResistors = _availableResistorsController.text
        .split(',')
        .map((e) => double.tryParse(e.trim()))
        .where((e) => e != null)
        .cast<double>()
        .toList();

    final results = JunkBoxSolverLogic.findCombinations(
      targetResistance,
      availableResistors,
      2, // For now, only 2 resistors
      0.01, // 1% tolerance
    );

    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBack(title: 'Junk Box Solver'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _targetResistanceController,
              decoration: const InputDecoration(
                labelText: 'Target Resistance (Ω)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _availableResistorsController,
              decoration: const InputDecoration(
                labelText: 'Available Resistors (comma-separated)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _solve,
              child: const Text('Find Combinations'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_results[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
