import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlameSplashScreen(
      theme: FlameSplashTheme.white,
      showBefore: (BuildContext context) => Center(child: SvgPicture.asset(ImageAssets.challengeLogo)),
      showAfter: (BuildContext context) => Center(child: Image.asset(ImageAssets.mtcLogo)),
      onFinish: (BuildContext context) => AppRouter.goToMenu(),
    );
  }
}
