import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/robot/rive_robot.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/game.dart';

class Robot extends PositionComponent {
  final RiveRobot riveRobot;

  Robot({required this.riveRobot});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
    initRobotClaws();
    add(riveRobot);
  }

  void initRobotClaws() {
    final leftClaw = RobotClaw(isLeft: true);
    final rightClaw = RobotClaw(isLeft: false);
    leftClaw.initialPositionX = worldSize.x / 5;
    leftClaw.initialPositionY = 1;
    rightClaw.initialPositionX = worldSize.x / 5;
    rightClaw.initialPositionY = 1;
    add(leftClaw);
    add(rightClaw);
  }

  void deploy() {
    riveRobot.deploy();
  }
}
