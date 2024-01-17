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
            paint: leftClaw.state == RobotState.deployed ? BasicPalette.red.paint() : BasicPalette.orange.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 50,
            paint: BasicPalette.darkRed.paint(),
          ),
          margin: const EdgeInsets.only(right: 140, bottom: 32),
        );

  void deploy() {
    robot.deploy();
    leftClaw.deploy();
    rightClaw.deploy();
  }

  void refold() {
    leftClaw.refold();
    rightClaw.refold();
  }

  @override
  Future<void> onLoad() {
    debugMode = kDebugMode;

    super.onPressed = () {
      if (leftClaw.state == RobotState.deployed) {
        refold();
        return;
      }

      deploy();
    };

    return super.onLoad();
  }
}
