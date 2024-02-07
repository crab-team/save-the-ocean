import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/widgets.dart';
import 'package:save_the_ocean/constants/assets.dart';

class MtcPresentationRive extends StatelessWidget {
  const MtcPresentationRive({super.key});

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      AnimationAssets.riv,
      artboard: ArtifactNames.mtcPresentation,
      fit: BoxFit.contain,
    );
  }
}
