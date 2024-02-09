import 'dart:js_interop';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/screens/loading_screen.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';
import 'package:save_the_ocean/providers/game_providers.dart';
import 'package:save_the_ocean/providers/pollution_level_providers.dart';
import 'package:save_the_ocean/providers/robot_deploy_provider.dart';
import 'package:save_the_ocean/providers/robot_position_provider.dart';
import 'package:save_the_ocean/providers/robot_release_trash_providers.dart';
import 'package:save_the_ocean/providers/score_provider.dart';
import 'package:save_the_ocean/utils/score.dart';

final saveTheOceanGame = SaveTheOceanGame();

// Providers
final recyclingNotifier = ValueNotifier<bool>(false);
final gameNotifier = GameNotifier();
final scoreNotifier = ScoreNotifier();
final robotDeployNotifier = RobotDeployNotifier();
final robotPositionNotifier = RobotPositionNotifier();
final robotReleaseTrashNotifier = RobotReleaseTrashNotifier();
final pollutionLevelNotifier = PollutionLevelNotifier();
final batteryLevelNotifier = BatteryLevelNotifier();

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: saveTheOceanGame,
      overlayBuilderMap: {
        'PauseMenu': _pauseMenuBuilder,
      },
      loadingBuilder: (_) => LoadingScreen(game: saveTheOceanGame),
    );
  }

  Widget _pauseMenuBuilder(BuildContext context, SaveTheOceanGame game) {
    String lastScore = ScoreUtils.getTimeFormatByDt(game.elapsedTime);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Stack(
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Game over',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 24),
                Image.asset("images/${ImageAssets.menuLine}", width: 500),
                const SizedBox(height: 24),
                Text(
                  'Recycling time',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  lastScore,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 24),
                Image.asset("images/${ImageAssets.menuBottomLine}", width: 500),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => _restartGame(),
                      child: Text(
                        'Restart',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(width: 100),
                    TextButton(
                      onPressed: () {
                        // gameNotifier.resetGame();
                        // gameNotifier.resumeGame();
                        AppRouter.goToMenu();
                      },
                      child: Text(
                        'Main menu',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    gameNotifier.restartGame();
  }
}
