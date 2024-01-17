import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';

class RobotReleaseButton extends HudButtonComponent {
  final Robot robot;
  final RobotClaw leftClaw;
  final RobotClaw rightClaw;

  @override
  Future<void> onLoad() {
    debugMode = kDebugMode;
    return super.onLoad();
  }

  RobotReleaseButton({required this.robot, required this.leftClaw, required this.rightClaw})
      : super(
          button: CircleComponent(
            radius: 40,
            paint: BasicPalette.green.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 40,
            paint: BasicPalette.darkRed.paint(),
          ),
          margin: const EdgeInsets.only(right: 48, bottom: 32),
          onPressed: () {
            leftClaw.open();
            rightClaw.open();
          },
        );
}
