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
      appBar: AppBar(title: const Text('Resistor Master')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DecoderView(),
                    ),
                  );
                },
                child: const Text('Through-Hole Decoder'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SmdDecoderView(),
                    ),
                  );
                },
                child: const Text('SMD Decoder'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ESeriesView(),
                    ),
                  );
                },
                child: const Text('E-Series Validator'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JunkBoxSolverView(),
                    ),
                  );
                },
                child: const Text('Junk Box Solver'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesView(),
                    ),
                  );
                },
                child: const Text('Favorites'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryView(),
                    ),
                  );
                },
                child: const Text('History'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PowerAnalysisView(),
                    ),
                  );
                },
                child: const Text('Power Calculator'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VoltageDividerView(),
                    ),
                  );
                },
                child: const Text('Voltage Divider'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LMatchView()),
                  );
                },
                child: const Text('L-Match Impedance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
