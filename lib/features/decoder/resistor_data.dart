import 'package:flutter/material.dart';

class ResistorData {
  static const Map<String, Color> colorMap = {
    'Black': Colors.black,
    'Brown': Colors.brown,
    'Red': Colors.red,
    'Orange': Colors.orange,
    'Yellow': Colors.yellow,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Violet': Colors.purple,
    'Grey': Colors.grey,
    'White': Colors.white,
    'Gold': Color(0xFFD4AF37),
    'Silver': Color(0xFFC0C0C0),
    'None': Colors.transparent,
  };

  static const Map<String, int> digitValues = {
    'Black': 0,
    'Brown': 1,
    'Red': 2,
    'Orange': 3,
    'Yellow': 4,
    'Green': 5,
    'Blue': 6,
    'Violet': 7,
    'Grey': 8,
    'White': 9,
  };

  static const Map<String, double> multiplierValues = {
    'Black': 1,
    'Brown': 10,
    'Red': 100,
    'Orange': 1000,
    'Yellow': 10000,
    'Green': 100000,
    'Blue': 1000000,
    'Violet': 10000000,
    'Gold': 0.1,
    'Silver': 0.01,
  };

  static const Map<String, double> toleranceValues = {
    'Brown': 1,
    'Red': 2,
    'Green': 0.5,
    'Blue': 0.25,
    'Violet': 0.1,
    'Grey': 0.05,
    'Gold': 5,
    'Silver': 10,
    'None': 20,
  };

  static const Map<String, int> tcrValues = {
    'Black': 250,
    'Brown': 100,
    'Red': 50,
    'Orange': 15,
    'Yellow': 25,
    'Green': 20,
    'Blue': 10,
    'Violet': 5,
    'Grey': 1,
  };
}
