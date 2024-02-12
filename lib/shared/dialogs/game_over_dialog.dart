import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/screens/game_screen.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/dialog.dart';
import 'package:save_the_ocean/utils/score.dart';

class GameOverDialog extends StatefulWidget {
  final SaveTheOceanGame game;
  const GameOverDialog({super.key, required this.game});

  @override
  State<GameOverDialog> createState() => _GameOverDialogState();
}

class _GameOverDialogState extends State<GameOverDialog> {
  String lastScore = "";
  String newScore = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await _updateScore(widget.game.elapsedTime);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    lastScore = _getLastScore();
    newScore = ScoreUtils.getTimeFormat(widget.game.elapsedTime);
    return CustomDialog(
      title: "The ocean is dead",
      actions: [
        TextButton(
          onPressed: () => _restartGame(),
          child: const AutoScaleText.body('Restart'),
        ),
        const SizedBox(width: 100),
        TextButton(
          onPressed: () {
            _restartGame();
            AppRouter.goToMenu();
          },
          child: const AutoScaleText.body('Main menu'),
        ),
      ],
      child: Column(
        children: [
          Visibility(
            visible: isLastScoreBetter,
            child: AutoScaleText.small('New record!', color: Theme.of(context).colorScheme.tertiary),
          ),
          const AutoScaleText.small('Recycling time'),
          AutoScaleText.body(newScore),
          const SizedBox(height: 24),
          const AutoScaleText.small('Last time'),
          AutoScaleText.body(lastScore),
        ],
      ),
    );
  }

  void _restartGame() {
    gameNotifier.restartGame();
  }

  Future<void> _updateScore(double elapsedTime) async {
    await Provider.of<UserController>(context, listen: false).updateScore(widget.game.elapsedTime);
  }

  String _getLastScore() {
    double lastScore = Provider.of<UserController>(context, listen: false).currentUser!.score;
    return ScoreUtils.getTimeFormat(lastScore);
  }

  bool get isLastScoreBetter {
    double lastScore = Provider.of<UserController>(context, listen: false).currentUser!.score;
    return lastScore < widget.game.elapsedTime;
  }
}
