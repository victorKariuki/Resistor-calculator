import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resistor_calculator/features/decoder/decoder_logic.dart';
import 'package:resistor_calculator/features/decoder/resistor_data.dart';
import 'package:resistor_calculator/features/decoder/widgets/band_selector.dart';
import 'package:resistor_calculator/features/decoder/widgets/resistance_display.dart';
import 'package:resistor_calculator/features/decoder/widgets/resistor_visualization.dart';
import 'package:resistor_calculator/features/decoder/widgets/reverse_lookup.dart';
import 'package:resistor_calculator/widgets/app_bar_back.dart';

class DecoderScreen extends StatelessWidget {
  const DecoderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DecoderLogic(),
      child: Consumer<DecoderLogic>(
        builder: (context, logic, child) {
          return Scaffold(
            appBar: const AppBarBack(title: 'Through-Hole Decoder'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ResistorVisualization(bandColors: logic.getBandColors()),
                  const SizedBox(height: 20),
                  const ResistanceDisplay(),
                  const SizedBox(height: 20),
                  const ReverseLookup(),
                  const SizedBox(height: 20),
                  Center(
                    child: SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 3, label: Text('3-Band')),
                        ButtonSegment(value: 4, label: Text('4-Band')),
                        ButtonSegment(value: 5, label: Text('5-Band')),
                        ButtonSegment(value: 6, label: Text('6-Band')),
                      ],
                      selected: {logic.bandCount},
                      onSelectionChanged: (newSelection) {
                        logic.setBandCount(newSelection.first);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  BandSelector(
                    label: '1st Band (Digit 1)',
                    currentValue: logic.band1Color,
                    onChanged: (color) => logic.setBandColor(1, color!),
                    items: ResistorData.digitValues.keys.toList(),
                  ),
                  BandSelector(
                    label: '2nd Band (Digit 2)',
                    currentValue: logic.band2Color,
                    onChanged: (color) => logic.setBandColor(2, color!),
                    items: ResistorData.digitValues.keys.toList(),
                  ),
                  if (logic.bandCount >= 5)
                    BandSelector(
                      label: '3rd Band (Digit 3)',
                      currentValue: logic.band3Color,
                      onChanged: (color) => logic.setBandColor(3, color!),
                      items: ResistorData.digitValues.keys.toList(),
                    ),
                  BandSelector(
                    label: 'Multiplier',
                    currentValue: logic.multiplierColor,
                    onChanged: (color) => logic.setBandColor(4, color!),
                    items: ResistorData.multiplierValues.keys.toList(),
                  ),
                  if (logic.bandCount > 3)
                    BandSelector(
                      label: 'Tolerance',
                      currentValue: logic.toleranceColor,
                      onChanged: (color) => logic.setBandColor(5, color!),
                      items: ResistorData.toleranceValues.keys.toList()..remove('None'),
                    ),
                  if (logic.bandCount == 6)
                    BandSelector(
                      label: 'TCR',
                      currentValue: logic.tcrColor,
                      onChanged: (color) => logic.setBandColor(6, color!),
                      items: ResistorData.tcrValues.keys.toList(),
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
