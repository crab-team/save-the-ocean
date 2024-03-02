import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> actions;

  const CustomDialog({super.key, required this.title, required this.child, required this.actions});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Stack(
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
              ),
            ),
          ),
          Center(
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoScaleText.subtitle(title),
                  const SizedBox(height: 12),
                  Transform.flip(
                    flipY: true,
                    child: Image.asset("assets/images/${ImageAssets.menuLine}", width: screenWidth * 0.6),
                  ),
                  const SizedBox(height: 12),
                  child,
                  const SizedBox(height: 12),
                  Image.asset("assets/images/${ImageAssets.menuLine}", width: screenWidth * 0.6),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: actions,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
