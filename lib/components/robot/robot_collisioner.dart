import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/inputs/joystick.dart';
import 'package:save_the_ocean/utils/logger.dart';

class RobotCollisioner extends BodyComponent with ContactCallbacks {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(worldSize.x / 2, 1.75),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2(-1, 0), Vector2(1, 0));
    final fixtureDef = FixtureDef(shape, userData: this, restitution: 0.0, friction: 0.7, density: 0.1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
  }

  @override
  void update(double dt) {
    super.update(dt);

    bool joystickLeft = joystick.direction == JoystickDirection.left;
    bool joystickRight = joystick.direction == JoystickDirection.right;
    bool joystickUp = joystick.direction == JoystickDirection.up;
    bool joystickDown = joystick.direction == JoystickDirection.down;

    if (joystickLeft) {
      position.x -= 0.2 * joystick.intensity;
    }

    if (joystickRight) {
      position.x += 0.2 * joystick.intensity;
    }

    if (joystickUp) {
      position.y -= 0.2 * joystick.intensity;
    }

    if (joystickDown) {
      position.y += 0.2 * joystick.intensity;
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    Logger.log('Collison detected with $other');
    body.applyLinearImpulse(Vector2(0, 0));
  }


  void deploy() {
    body.applyLinearImpulse(Vector2(0, 2));
  }
}
