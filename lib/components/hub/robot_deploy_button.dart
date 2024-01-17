import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';

import '../robot/robot_controller.dart';

class RobotDeployButton extends HudButtonComponent {
  final Robot robot;
  final RobotClaw leftClaw;
  final RobotClaw rightClaw;

  RobotDeployButton({required this.robot, required this.leftClaw, required this.rightClaw})
      : super(
          button: CircleComponent(
            radius: 50,
            paint: BasicPalette.red.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 50,
            paint: BasicPalette.darkRed.paint(),
          ),
          margin: const EdgeInsets.only(right: 140, bottom: 32),
          onPressed: () {
            robot.deploy();

            if (leftClaw.state == RobotState.deployed) {
              leftClaw.refold();
              rightClaw.refold();
              return;
            }
            leftClaw.deploy();
            rightClaw.deploy();
          },
        );

  @override
  Future<void> onLoad() {
    debugMode = kDebugMode;
    return super.onLoad();
  }
}
