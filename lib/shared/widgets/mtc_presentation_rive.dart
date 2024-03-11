import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/utils/preload_rive.dart';

class MtcPresentationRive extends StatelessWidget {
  const MtcPresentationRive({super.key});

  @override
  Widget build(BuildContext context) {
    return context.read<RiveAnimationProvider>().mtcPresentationAnimation;
  }
}
