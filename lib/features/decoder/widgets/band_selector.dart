import 'package:flutter/material.dart';
import 'package:resistor_calculator/features/decoder/resistor_data.dart';

class BandSelector extends StatelessWidget {
  final String label;
  final String currentValue;
  final ValueChanged<String?> onChanged;
  final List<String> items;

  const BandSelector({
    super.key,
    required this.label,
    required this.currentValue,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        border: color == 'White' || color == 'None' ? Border.all(color: Colors.black54) : null,
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
