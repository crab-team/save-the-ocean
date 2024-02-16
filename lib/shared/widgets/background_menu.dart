import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/utils/preload_rive.dart';

class BackgroundMenu extends StatelessWidget {
  final bool withFilter;

  const BackgroundMenu({super.key, this.withFilter = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/${ImageAssets.backgroundFar}',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        context.read<RiveAnimationProvider>().fishRiveAnimation,
        Image.asset(
          'assets/images/${ImageAssets.backgroundFront}',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Image.asset(
          'assets/images/${ImageAssets.foreground}',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Visibility(
          visible: withFilter,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
