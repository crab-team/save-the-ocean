import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/assets.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> actions;

  const CustomDialog({super.key, required this.title, required this.child, required this.actions});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 24),
                Image.asset("assets/images/${ImageAssets.menuLine}", width: 500),
                const SizedBox(height: 24),
                SizedBox(width: MediaQuery.of(context).size.width * 0.4, child: child),
                const SizedBox(height: 24),
                Image.asset("assets/images/${ImageAssets.menuBottomLine}", width: 500),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: actions,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
