import 'package:go_router/go_router.dart';
import 'package:resistor_calculator/features/about/about_view.dart';
import 'package:resistor_calculator/features/favorites/favorites_view.dart';
import 'package:resistor_calculator/features/history/history_view.dart';
import 'package:resistor_calculator/features/home/home_routes.dart';
import 'package:resistor_calculator/features/settings/settings_view.dart';
import 'package:resistor_calculator/home_screen.dart';
import 'package:resistor_calculator/main.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [buildHomeRoute()],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(path: '/about', builder: (context, state) => const AboutView()),
    ],
  );

  static GoRoute buildHomeRoute() {
    return GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: homeRoutes,
    );
  }
}
