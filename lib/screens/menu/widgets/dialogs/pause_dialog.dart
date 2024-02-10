import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/app.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/shared/widgets/dialog.dart';

class PauseDialog extends StatelessWidget {
  final SaveTheOceanGame game;

  const PauseDialog({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "Pause",
      actions: [
        TextButton(
          onPressed: () => _resumeGame(),
          child: const Text("Resume"),
        ),
        const SizedBox(width: 100),
        TextButton(
          onPressed: () => AppRouter.goToMenu(),
          child: const Text("Go to menu"),
        ),
      ],
      child: Center(
          child: Text(
        "El último registro indico un incremento del 26% de plásticos en el oceano.",
        style: Theme.of(context).textTheme.displaySmall,
        textAlign: TextAlign.center,
      )),
    );
  }

  void _resumeGame() {
    game.overlays.remove(AppConstants.pauseDialog);
    game.restart();
    game.resumeEngine();
  }
}
