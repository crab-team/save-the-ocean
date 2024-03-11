import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/app.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/screens/game/game.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/dialog.dart';

class TutorialDialog extends StatefulWidget {
  final SaveTheOceanGame game;
  const TutorialDialog({super.key, required this.game});

  @override
  State<TutorialDialog> createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog> {
  bool isTutorial1 = true;

  @override
  void initState() {
    super.initState();
    widget.game.pauseEngine();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return CustomDialog(
      title: "How to play",
      actions: [
        TextButton(
          onPressed: () => isTutorial1 ? _goToTutorial2() : _startGame(),
          child: AutoScaleText.body(isTutorial1 ? 'Continue' : 'Start'),
        ),
      ],
      child: isTutorial1
          ? Image.asset(
              "assets/images/${ImageAssets.tutorial1}",
              width: screenWidth * 0.4,
            )
          : Image.asset(
              "assets/images/${ImageAssets.tutorial2}",
              width: screenWidth * 0.4,
            ),
    );
  }

  void _goToTutorial2() {
    setState(() {
      isTutorial1 = false;
    });
  }

  void _startGame() {
    widget.game.overlays.remove(AppConstants.tutorialDialog);
    widget.game.resumeEngine();
    Provider.of<UserController>(context, listen: false).saveFirstTime();
  }
}
