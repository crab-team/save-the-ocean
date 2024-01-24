import 'dart:async';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/robot/rive_robot.dart';
import 'package:save_the_ocean/game.dart';

class Robot extends BodyComponent {
  final RiveRobot riveRobot;

  Robot({required this.riveRobot});

  @override
  Body createBody() {
    BodyDef bodyDef = BodyDef(
      position: Vector2(worldSize.x / 2, 1.75),
      type: BodyType.static,
    );

    return world.createBody(bodyDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
    add(riveRobot);
  }

  void deploy() {
    riveRobot.deploy();
  }
}
