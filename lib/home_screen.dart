
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resistor Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: [
            _buildFeatureCard(
              context,
              title: '4-5 Band Resistor Decoder',
              icon: Icons.calculate,
              routeName: '/decoder',
            ),
            _buildFeatureCard(
              context,
              title: 'SMD Resistor Decoder',
              icon: Icons.memory,
              routeName: '/smd_decoder',
            ),
            _buildFeatureCard(
              context,
              title: 'E-Series Values',
              icon: Icons.format_list_numbered,
              routeName: '/e_series',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {required String title, required IconData icon, required String routeName}) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, routeName),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0),
            const SizedBox(height: 8.0),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
