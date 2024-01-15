import 'dart:async';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/robot/body/rive_robot_body.dart';
import 'package:save_the_ocean/game.dart';

class RobotBody extends BodyComponent {
  final RiveRobotBody riveBody;

  RobotBody({required this.riveBody});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x / 2, 2),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2(-1, 0), Vector2(1, 0));

    final fixtureDef = FixtureDef(
      shape,
      userData: this,
      density: 0.1,
      friction: 0.1,
      restitution: 0,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
    add(riveBody);
  }
}

