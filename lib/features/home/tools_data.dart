import 'package:flutter/material.dart';

class Tool {
  final IconData icon;
  final String title;
  final String path;

  const Tool({required this.icon, required this.title, required this.path});
}

const List<Tool> tools = [
  Tool(icon: Icons.electrical_services, title: 'Through-Hole Decoder', path: '/home/decoder'),
  Tool(icon: Icons.memory, title: 'SMD Decoder', path: '/home/smd-decoder'),
  Tool(icon: Icons.format_list_numbered, title: 'E-Series Validator', path: '/home/e-series'),
  Tool(icon: Icons.inventory_2, title: 'Junk Box Solver', path: '/home/junk-box'),
  Tool(icon: Icons.power, title: 'Power Calculator', path: '/home/power'),
  Tool(icon: Icons.mediation, title: 'Voltage Divider', path: '/home/voltage-divider'),
  Tool(icon: Icons.network_check, title: 'L-Match Impedance', path: '/home/l-match'),
];
