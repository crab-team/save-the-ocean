import 'dart:ui';

import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/assets.dart';

class BackgroundMenu extends StatelessWidget {
  const BackgroundMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/${ImageAssets.backgroundMenu}',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Image.asset(
          'assets/images/${ImageAssets.foregroundTopWall}',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          left: -10,
          bottom: 0,
          width: 140,
          child: Image.asset(
            'assets/images/${ImageAssets.foregroundLeftWall}',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: -5,
          bottom: 0,
          width: 140,
          child: Image.asset('assets/images/${ImageAssets.foregroundRightWall}'),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 120,
          child: Image.asset(
            'assets/images/${ImageAssets.foregroundBottom}',
          ),
        ),
        const RiveAnimation.asset(
          AnimationAssets.riv,
          artboard: ArtboardNames.lighting,
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
            ),
          ),
        ),
      ],
    );
  }
}
