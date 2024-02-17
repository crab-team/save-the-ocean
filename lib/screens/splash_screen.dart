import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/audio/audio_controller.dart';
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

  void initAudio() {
    if (kIsWeb) {
      return;
    }

    Provider.of<AudioController>(context, listen: false).play();
  }
}
