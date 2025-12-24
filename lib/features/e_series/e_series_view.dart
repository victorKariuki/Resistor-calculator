import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resistor_calculator/features/e_series/e_series_data.dart';
import 'package:resistor_calculator/features/e_series/e_series_logic.dart';
import 'package:resistor_calculator/widgets/app_bar_back.dart';

class ESeriesView extends StatelessWidget {
  const ESeriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ESeriesLogic(),
      child: Consumer<ESeriesLogic>(
        builder: (context, logic, child) {
          return Scaffold(
            appBar: const AppBarBack(title: 'E-Series Validator'),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: logic.resistanceController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Resistance (Ω)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<ESeries>(
                    value: logic.selectedSeries,
                    onChanged: (ESeries? newValue) {
                      if (newValue != null) {
                        logic.setSelectedSeries(newValue);
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
                    onPressed: logic.validateAndQuantize,
                    child: const Text('Validate & Quantize'),
                  ),
                  const SizedBox(height: 30),
                  if (logic.validationResult.isNotEmpty)
                    Text(
                      logic.validationResult,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: logic.validationResult == 'Standard Value' ? Colors.green : Colors.orange,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  if (logic.nearestValue.isNotEmpty)
                    Text(
                      logic.nearestValue,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
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
