import 'package:go_router/go_router.dart';
import 'package:resistor_calculator/features/decoder/decoder_screen.dart';
import 'package:resistor_calculator/features/e_series/e_series_view.dart';
import 'package:resistor_calculator/features/junk_box_solver/junk_box_solver_view.dart';
import 'package:resistor_calculator/features/power_analysis/power_analysis_view.dart';
import 'package:resistor_calculator/features/circuit_synthesis/voltage_divider/voltage_divider_view.dart';
import 'package:resistor_calculator/features/rf_analysis/l_match/l_match_view.dart';
import 'package:resistor_calculator/features/smd_decoder/smd_decoder_view.dart';

final homeRoutes = [
  GoRoute(
    path: 'decoder',
    builder: (context, state) => const DecoderScreen(),
  ),
  GoRoute(
    path: 'smd-decoder',
    builder: (context, state) => const SmdDecoderView(),
  ),
  GoRoute(
    path: 'e-series',
    builder: (context, state) => const ESeriesView(),
  ),
  GoRoute(
    path: 'junk-box',
    builder: (context, state) => const JunkBoxSolverView(),
  ),
  GoRoute(
    path: 'power',
    builder: (context, state) => const PowerAnalysisView(),
  ),
  GoRoute(
    path: 'voltage-divider',
    builder: (context, state) => const VoltageDividerView(),
  ),
  GoRoute(
    path: 'l-match',
    builder: (context, state) => const LMatchView(),
  ),
];
