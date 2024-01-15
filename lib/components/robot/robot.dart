import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/robot/body/robot_body.dart';
import 'package:save_the_ocean/components/robot/head/robot_head.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

class Robot extends PositionComponent {
  final RobotHead robotHead;
  final RobotBody robotBody;

  Robot({required this.robotHead, required this.robotBody});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;

    position = Vector2(worldSize.x / 2, 0);

    add(robotHead);
    add(robotBody);
  }

  @override
  void update(double dt) {
    super.update(dt);

    bool joystickLeft = joystick.direction == JoystickDirection.left;
    bool joystickRight = joystick.direction == JoystickDirection.right;

    if (joystickLeft) {
      moveLeft();
    }

    if (joystickRight) {
      moveRight();
    }
  }

  void moveLeft() {
    position.x -= 0.2 * joystick.intensity;
  }

  void moveRight() {
    position.x += 0.2 * joystick.intensity;
  }

  void aspire() {
    robotHead.aspire();
    robotBody.body.linearVelocity = Vector2(0, 1);
    robotBody.riveBody.aspire();
  }
}
