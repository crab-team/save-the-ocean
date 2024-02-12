import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/app.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/dialog.dart';

class PauseDialog extends StatelessWidget {
  final SaveTheOceanGame game;

  const PauseDialog({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return CustomDialog(
      title: "Pause",
      actions: const [],
      child: Column(
        children: [
          TextButton(
            onPressed: () => _resumeGame(),
            child: const AutoScaleText.body("Resume"),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => AppRouter.goToMenu(),
            child: const AutoScaleText.body("Go to menu"),
          ),
          Image.asset("assets/images/${ImageAssets.menuBottomLine}", width: screenWidth * 0.6),
        ],
      ),
    );
  }

  void _resumeGame() {
    game.overlays.remove(AppConstants.pauseDialog);
    game.restart();
    game.resumeEngine();
  }
}
