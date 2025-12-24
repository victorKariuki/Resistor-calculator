
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resistor_calculator/features/decoder/decoder_view.dart';
import 'package:resistor_calculator/features/e_series/e_series_view.dart';
import 'package:resistor_calculator/features/favorites/favorites_manager.dart';
import 'package:resistor_calculator/features/history/history_manager.dart';
import 'package:resistor_calculator/features/smd_decoder/smd_decoder_view.dart';
import 'package:resistor_calculator/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesManager()),
        ChangeNotifierProvider(create: (_) => HistoryManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resistor Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/decoder': (context) => const DecoderView(),
        '/smd_decoder': (context) => const SmdDecoderView(),
        '/e_series': (context) => const ESeriesView(),
      },
    );
  }
}
