import 'package:flutter/material.dart';

class ResistorPainter extends CustomPainter {
  final List<Color> bandColors;

  ResistorPainter({required this.bandColors});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double bodyWidth = width * 0.7;
    final double bodyHeight = height * 0.6;
    final double leadWidth = width * 0.15;
    final double leadHeight = height * 0.1;
    final double bandWidth = bodyWidth * 0.1;
    final double bandSpacing = bandWidth * 1.5;

    final Paint bodyPaint = Paint()..color = const Color(0xFFF5DEB3); // Beige
    final Paint leadPaint = Paint()..color = Colors.grey[700]!;

    // Draw resistor body
    final RRect bodyRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: size.center(Offset.zero), width: bodyWidth, height: bodyHeight),
      const Radius.circular(10),
    );
    canvas.drawRRect(bodyRRect, bodyPaint);

    // Draw leads
    final double leadY = size.center(Offset.zero).dy - leadHeight / 2;
    final Rect leftLead = Rect.fromLTWH(0, leadY, leadWidth, leadHeight);
    final Rect rightLead =
        Rect.fromLTWH(width - leadWidth, leadY, leadWidth, leadHeight);
    canvas.drawRect(leftLead, leadPaint);
    canvas.drawRect(rightLead, leadPaint);

    // Draw bands
    int bandCount = bandColors.length;
    double startX;

    if (bandCount <= 4) {
      startX = leadWidth + bodyWidth * 0.15;
    } else {
      startX = leadWidth + bodyWidth * 0.1;
    }

    // First 3 or 4 bands (left side)
    int leftBandCount = (bandCount == 5 || bandCount == 6) ? 3 : 2;
    for (int i = 0; i < leftBandCount; i++) {
      _drawBand(canvas, startX + i * bandSpacing, height, bodyHeight,
          bandWidth, bandColors[i]);
    }

    // Multiplier band
    _drawBand(canvas, startX + leftBandCount * bandSpacing, height, bodyHeight,
        bandWidth, bandColors[leftBandCount]);

    // Tolerance and TCR bands (right side)
    if (bandCount > 3) {
      double rightStartX = width - leadWidth - bodyWidth * 0.15 - bandWidth;
      if (bandCount == 6) {
        _drawBand(canvas, rightStartX - bandSpacing, height, bodyHeight,
            bandWidth, bandColors[bandCount - 2]); // Tolerance
        _drawBand(canvas, rightStartX, height, bodyHeight, bandWidth,
            bandColors[bandCount - 1]); // TCR
      } else if (bandCount >=4) {
        _drawBand(canvas, rightStartX, height, bodyHeight, bandWidth,
            bandColors[bandCount - 1]); // Tolerance
      }
    }
  }

  void _drawBand(Canvas canvas, double x, double height, double bodyHeight,
      double bandWidth, Color color) {
    final Paint bandPaint = Paint()..color = color;
    final Rect bandRect =
        Rect.fromLTWH(x, (height - bodyHeight) / 2, bandWidth, bodyHeight);
    canvas.drawRect(bandRect, bandPaint);
  }

  @override
  bool shouldRepaint(covariant ResistorPainter oldDelegate) {
    return oldDelegate.bandColors != bandColors;
  }
}
