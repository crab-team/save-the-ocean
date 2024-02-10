import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/app.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';
import 'package:save_the_ocean/providers/game_providers.dart';
import 'package:save_the_ocean/providers/pollution_level_providers.dart';
import 'package:save_the_ocean/providers/robot_deploy_provider.dart';
import 'package:save_the_ocean/providers/robot_position_provider.dart';
import 'package:save_the_ocean/providers/robot_release_trash_providers.dart';
import 'package:save_the_ocean/screens/menu/widgets/dialogs/game_over_dialog.dart';
import 'package:save_the_ocean/screens/menu/widgets/dialogs/pause_dialog.dart';

// Notifiers
final recyclingNotifier = ValueNotifier<bool>(false);
final gameNotifier = GameNotifier();
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
      game: SaveTheOceanGame(),
      overlayBuilderMap: {
        AppConstants.pauseDialog: (BuildContext context, SaveTheOceanGame game) => PauseDialog(game: game),
        AppConstants.gameOverDialog: (BuildContext context, SaveTheOceanGame game) => GameOverDialog(game: game),
      },
    );
  }
}
