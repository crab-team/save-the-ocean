import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_the_ocean/page_transition.dart';
import 'package:save_the_ocean/screens/game_screen.dart';
import 'package:save_the_ocean/screens/menu/menu_screen.dart';
import 'package:save_the_ocean/screens/ranking_screen.dart';
import 'package:save_the_ocean/screens/splash_screen.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.

const transitionColor = Color(0xFF5cdbde);

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      pageBuilder: (context, state) => buildPageTransition<void>(
        key: const ValueKey('splash'),
        color: transitionColor,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/menu',
      name: 'menu',
      pageBuilder: (context, state) => buildPageTransition<void>(
        key: const ValueKey('menu'),
        color: transitionColor,
        child: const MenuScreen(),
      ),
      routes: [
        GoRoute(
          path: 'game',
          name: 'game',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('game'),
            color: transitionColor,
            child: const GameScreen(),
          ),
        ),
        GoRoute(
          path: 'ranking',
          name: 'ranking',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('ranking'),
            color: transitionColor,
            child: const RankingScreen(),
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

  static goToRanking() => router.go('/menu/ranking');
}
