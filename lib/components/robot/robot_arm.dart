import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/robot/left_claw.dart';
import 'package:save_the_ocean/components/robot/right_claw.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/utils/logger.dart';

class RobotArm extends PositionComponent {
  final LeftClaw leftClaw = LeftClaw();
  final RightClaw rightClaw = RightClaw();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;

    position = Vector2.zero();

    add(leftClaw);
    add(rightClaw);
  }

  @override
  void update(double dt) {
    super.update(dt);

    Logger.log('Arm position: $position');
    Logger.log('Left position: ${leftClaw.position}');
    Logger.log('Right position: ${rightClaw.position}');

    if (isDeploying && position.y <= worldSize.y - 3) {
      position.y += 0.05;
    }

    if (isRefolding && position.y > 0) {
      position.y -= 0.05;
    }

    if (leftClaw.body.angle <= -12.3) {
      leftClaw.body.angularVelocity = 0;
    }

    if (rightClaw.body.angle >= 12.3) {
      rightClaw.body.angularVelocity = 0;
    }
  }

  bool isDeploying = false;
  bool isRefolding = false;

  void deploy() {
    if (isDeploying) {
      if (leftClaw.body.angle > -12.3) {
        leftClaw.body.angularVelocity = -1;
      }

      if (rightClaw.body.angle < 12.3) {
        rightClaw.body.angularVelocity = 1;
      }

      Future.delayed(const Duration(seconds: 2), () {
        isDeploying = false;
        isRefolding = true;
      });

    } else {
      // leftClaw.body.linearVelocity = Vector2(0, 1.5);
      // rightClaw.body.linearVelocity = Vector2(0, 1.5);
      isDeploying = true;
      isRefolding = false;
    }
  }

  void closeClaw() {}

  void refold() {}

  void openClaw() {}
}
