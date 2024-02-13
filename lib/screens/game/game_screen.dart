import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/app.dart';
import 'package:save_the_ocean/screens/game/game.dart';
import 'package:save_the_ocean/controllers/game/battery_level_controller.dart';
import 'package:save_the_ocean/controllers/game/game_controller.dart';
import 'package:save_the_ocean/controllers/game/pollution_level_controller.dart';
import 'package:save_the_ocean/controllers/game/robot_deploy_controller.dart';
import 'package:save_the_ocean/controllers/game/robot_position_controller.dart';
import 'package:save_the_ocean/controllers/game/robot_release_garbage_controller.dart';
import 'package:save_the_ocean/shared/dialogs/game_over_dialog.dart';
import 'package:save_the_ocean/shared/dialogs/pause_dialog.dart';

// Controllers
final recyclingController = ValueNotifier<bool>(false);
final gameController = GameController();
final robotDeployController = RobotDeployController();
final robotPositionController = RobotPositionController();
final robotReleaseGarbageController = RobotReleaseGarbageController();
final pollutionLevelController = PollutionLevelController();
final batteryLevelController = BatteryLevelController();

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
