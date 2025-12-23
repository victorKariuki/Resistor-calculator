import 'package:flutter/material.dart';
import 'features/circuit_synthesis/voltage_divider/voltage_divider_view.dart';
import 'features/decoder/decoder_view.dart';
import 'features/e_series/e_series_view.dart';
import 'features/favorites/favorites_view.dart';
import 'features/history/history_view.dart';
import 'features/junk_box_solver/junk_box_solver_view.dart';
import 'features/power_analysis/power_analysis_view.dart';
import 'features/rf_analysis/l_match/l_match_view.dart';
import 'features/smd_decoder/smd_decoder_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resistor Calculator')),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.electrical_services),
            title: const Text('Through-Hole Decoder'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DecoderView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.memory),
            title: const Text('SMD Decoder'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SmdDecoderView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_list_numbered),
            title: const Text('E-Series Validator'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ESeriesView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Junk Box Solver'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JunkBoxSolverView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.power),
            title: const Text('Power Calculator'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PowerAnalysisView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.mediation),
            title: const Text('Voltage Divider'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VoltageDividerView(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.network_check),
            title: const Text('L-Match Impedance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LMatchView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
