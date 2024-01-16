import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/components/robot/robot.dart';

class RobotDeployButton extends HudButtonComponent {
  final Robot robot;

  RobotDeployButton({required this.robot})
      : super(
          button: CircleComponent(
            radius: 50,
            paint: BasicPalette.red.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 50,
            paint: BasicPalette.darkRed.paint(),
          ),
          margin: const EdgeInsets.only(right: 48, bottom: 32),
          onPressed: () {
            robot.deploy();
          },
        );

  @override
  Future<void> onLoad() {
    debugMode = kDebugMode;
    return super.onLoad();
  }
}
