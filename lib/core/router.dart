import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_the_ocean/page_transition.dart';
import 'package:save_the_ocean/screens/game_screen.dart';
import 'package:save_the_ocean/screens/menu/menu_screen.dart';
import 'package:save_the_ocean/screens/settings_screen.dart';
import 'package:save_the_ocean/screens/splash_screen.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      pageBuilder: (context, state) => buildPageTransition<void>(
        key: const ValueKey('splash'),
        color: Colors.blueGrey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/menu',
      name: 'menu',
      pageBuilder: (context, state) => buildPageTransition<void>(
        key: const ValueKey('menu'),
        color: Colors.blueGrey,
        child: const MenuScreen(),
      ),
      routes: [
        GoRoute(
          path: 'game',
          name: 'game',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('game'),
            color: Colors.blueGrey,
            child: const GameScreen(),
          ),
        ),
        GoRoute(
          path: 'settings',
          name: 'settings',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('settings'),
            color: Colors.blueGrey,
            child: const SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
);

class AppRouter {
  static back() => router.pop();

  static goToMenu() => router.go('/menu');

  static goToGame() => router.go('/menu/game');

  static goToSettings() => router.go('/menu/settings');
}
