import 'package:flutter/material.dart';
import '../favorites/favorites_manager.dart';
import '../history/history_manager.dart';
import 'resistor_data.dart';
import 'resistor_painter.dart';
import 'reverse_lookup.dart';

class DecoderView extends StatefulWidget {
  const DecoderView({super.key});

  @override
  State<DecoderView> createState() => _DecoderViewState();
}

class _DecoderViewState extends State<DecoderView> {
  int _bandCount = 4;
  String _band1Color = 'Brown';
  String _band2Color = 'Black';
  String _band3Color = 'Black'; // For 5/6-band
  String _multiplierColor = 'Red';
  String _toleranceColor = 'Gold';
  String _tcrColor = 'Brown'; // For 6-band

  String _resistance = '';
  String _tolerance = '';
  String _tcr = '';

  final _reverseLookupController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _calculateResistance();
  }

  @override
  void dispose() {
    _reverseLookupController.dispose();
    super.dispose();
  }

  void _calculateResistance() {
    int digit1 = ResistorData.digitValues[_band1Color]!;
    int digit2 = ResistorData.digitValues[_band2Color]!;
    int digit3 = _bandCount >= 5 ? ResistorData.digitValues[_band3Color]! : 0;
    double multiplier = ResistorData.multiplierValues[_multiplierColor]!;
    double toleranceValue = _bandCount == 3
        ? ResistorData.toleranceValues['None']!
        : ResistorData.toleranceValues[_toleranceColor]!;
    int? tcrValue = _bandCount == 6 ? ResistorData.tcrValues[_tcrColor] : null;

    double resistanceValue;
    if (_bandCount >= 5) {
      resistanceValue = (digit1 * 100 + digit2 * 10 + digit3) * multiplier;
    } else {
      resistanceValue = (digit1 * 10 + digit2) * multiplier;
    }

    final resistanceString = _formatResistance(resistanceValue);
    final toleranceString = '±$toleranceValue%';
    final tcrString = tcrValue != null ? '$tcrValue ppm/K' : '';

    setState(() {
      _resistance = resistanceString;
      _tolerance = toleranceString;
      _tcr = tcrString;
    });

    // Add to history
    final historyEntry = '$resistanceString $toleranceString${tcrString.isNotEmpty ? ' $tcrString' : ''}';
    HistoryManager.addHistory(historyEntry);
  }

  String _formatResistance(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(2)} GΩ';
    }
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)} MΩ';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)} kΩ';
    }
    return '${value.toStringAsFixed(2)} Ω';
  }

  void _performReverseLookup() {
    final String text = _reverseLookupController.text;
    final double? resistance = ReverseLookup.parseResistance(text);

    if (resistance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid resistance value')),
      );
      return;
    }

    final ReverseLookupResult? result = ReverseLookup.findBands(resistance, _bandCount);

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not find a matching resistor')),
      );
      return;
    }

    setState(() {
      _band1Color = result.band1Color;
      _band2Color = result.band2Color;
      if (_bandCount >= 5) {
        _band3Color = result.band3Color!;
      }
      _multiplierColor = result.multiplierColor;
      _calculateResistance(); // This will also add to history
      // Also update the displayed value to the actual standard value found
       _reverseLookupController.text = _formatResistance(result.actualResistance);
    });
  }

  List<Color> _getBandColors() {
    List<Color> colors = [];
    colors.add(ResistorData.colorMap[_band1Color]!);
    colors.add(ResistorData.colorMap[_band2Color]!);
    if (_bandCount >= 5) {
      colors.add(ResistorData.colorMap[_band3Color]!);
    }
    colors.add(ResistorData.colorMap[_multiplierColor]!);
    if (_bandCount > 3) {
      colors.add(ResistorData.colorMap[_toleranceColor]!);
    }
    if (_bandCount == 6) {
      colors.add(ResistorData.colorMap[_tcrColor]!);
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Through-Hole Decoder'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Resistor Visualization
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: CustomPaint(
                painter: ResistorPainter(bandColors: _getBandColors()),
                size: Size.infinite,
              ),
            ),
            const SizedBox(height: 20),

            // Resistance Display
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Resistance',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 10),
                    Text(
                      '$_resistance $_tolerance',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (_tcr.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text('TCR: $_tcr',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_resistance.isNotEmpty) {
                          final valueToSave = '$_resistance $_tolerance${_tcr.isNotEmpty ? ' $_tcr' : ''}';
                          FavoritesManager.addFavorite(valueToSave);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Saved "$valueToSave" to favorites.')),
                          );
                        }
                      },
                      icon: const Icon(Icons.favorite_border),
                      label: const Text('Save to Favorites'),
                    ),
                  ],
                ),
              ),
            ),
             const SizedBox(height: 20),

            // Reverse Lookup
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                     Text('Reverse Lookup', style: Theme.of(context).textTheme.titleLarge),
                     const SizedBox(height: 10),
                    TextField(
                      controller: _reverseLookupController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Resistance (e.g., 4.7k)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: _performReverseLookup, child: const Text('Find Colors'))
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Band Count Selector
            Center(
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 3, label: Text('3-Band')),
                  ButtonSegment(value: 4, label: Text('4-Band')),
                  ButtonSegment(value: 5, label: Text('5-Band')),
                  ButtonSegment(value: 6, label: Text('6-Band')),
                ],
                selected: {_bandCount},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _bandCount = newSelection.first;
                    _calculateResistance();
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // Color Band Selectors
            _buildBandSelector('1st Band (Digit 1)', _band1Color, (color) {
              setState(() {
                _band1Color = color!;
                _calculateResistance();
              });
            }, ResistorData.digitValues.keys.toList()),

            _buildBandSelector('2nd Band (Digit 2)', _band2Color, (color) {
              setState(() {
                _band2Color = color!;
                _calculateResistance();
              });
            }, ResistorData.digitValues.keys.toList()),

            if (_bandCount >= 5)
              _buildBandSelector('3rd Band (Digit 3)', _band3Color, (color) {
                setState(() {
                  _band3Color = color!;
                  _calculateResistance();
                });
              }, ResistorData.digitValues.keys.toList()),

            _buildBandSelector('Multiplier', _multiplierColor, (color) {
              setState(() {
                _multiplierColor = color!;
                _calculateResistance();
              });
            }, ResistorData.multiplierValues.keys.toList()),

            if (_bandCount > 3)
              _buildBandSelector('Tolerance', _toleranceColor, (color) {
                setState(() {
                  _toleranceColor = color!;
                  _calculateResistance();
                });
              }, ResistorData.toleranceValues.keys.toList()..remove('None')),

            if (_bandCount == 6)
              _buildBandSelector('TCR', _tcrColor, (color) {
                setState(() {
                  _tcrColor = color!;
                  _calculateResistance();
                });
              }, ResistorData.tcrValues.keys.toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildBandSelector(
    String label,
    String currentValue,
    ValueChanged<String?> onChanged,
    List<String> items,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentValue,
            isDense: true,
            isExpanded: true,
            items: items.map((String color) {
              return DropdownMenuItem<String>(
                value: color,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: ResistorData.colorMap[color],
                        border: color == 'White' || color == 'None'
                            ? Border.all(color: Colors.black54)
                            : null,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(color),
                  ],
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
