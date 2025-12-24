import 'package:flutter/material.dart';
import 'package:resistor_calculator/features/decoder/resistor_painter.dart';

class ResistorVisualization extends StatelessWidget {
  final List<Color> bandColors;

  const ResistorVisualization({super.key, required this.bandColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: CustomPaint(
        painter: ResistorPainter(bandColors: bandColors),
        size: Size.infinite,
      ),
    );
  }
}
