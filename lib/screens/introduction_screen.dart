import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/utils/preload_rive.dart';

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
          context.read<RiveAnimationProvider>().introductionScreenAnimation,
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
