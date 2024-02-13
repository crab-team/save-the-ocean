import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 28), () {
      AppRouter.goToGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          const RiveAnimation.asset(
            AnimationAssets.riv,
            artboard: ArtboardNames.introductionScreen,
            fit: BoxFit.contain,
          ),
          Positioned(
            child: TextButton(
              onPressed: () {
                AppRouter.goToGame();
              },
              child: const AutoScaleText.body("Skip"),
            ),
          )
        ],
      ),
    );
  }
}