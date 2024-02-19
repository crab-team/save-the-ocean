import 'package:flame_audio/flame_audio.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/screens/menu/widgets/allow_audio_web_button.dart';
import 'package:save_the_ocean/shared/widgets/mtc_presentation_rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final flameController = FlameSplashController(waitDuration: const Duration(seconds: 4));

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlameSplashScreen(
          controller: flameController,
          theme: FlameSplashTheme.white,
          showBefore: (BuildContext context) => Center(child: SvgPicture.asset(ImageAssets.challengeLogo)),
          showAfter: (BuildContext context) => const Center(child: MtcPresentationRive()),
          onFinish: (BuildContext context) => AppRouter.goToMenu(),
        ),
        const Visibility(
          visible: kIsWeb,
          child: Positioned(top: 10, right: 10, child: AllowAudioWebButton()),
        ),
      ],
    );
  }

  Future<void> initAudio() async {
    if (kIsWeb) {
      return;
    }

    await FlameAudio.bgm.play(AudioAssets.music, volume: 0.2);
    await FlameAudio.audioCache.loadAll([
      AudioAssets.reward,
      AudioAssets.batteryReward,
      AudioAssets.garbageFloor,
      AudioAssets.gameOver,
    ]);
  }
}
