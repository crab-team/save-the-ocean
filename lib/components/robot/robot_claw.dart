import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/game.dart';

class RobotClaw extends BodyComponent {
  final bool isLeft;

  RobotClaw({required this.isLeft});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x / 2, 1),
      angle: _getAngle(),
      type: BodyType.kinematic,
    );

    final shape = _createShape();
    final fixtureDef = FixtureDef(shape, friction: 0.9);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
  }

  bool isDeploying = false;
  bool isRefolding = false;

  @override
  void update(double dt) {
    super.update(dt);

    if (isDeploying && position.y >= worldSize.y - 1.5) {
      stop();
    }

    if (isRefolding && position.y <= 1) {
      stop();
      isRefolding = false;
    }

    if (isLeft && body.angle <= -12.3) {
      body.angularVelocity = 0;
    }

    if (!isLeft && body.angle >= 12.3) {
      body.angularVelocity = 0;
    }
  }

  void deploy() {
    if (!isDeploying && !isRefolding) {
      isDeploying = true;
      isRefolding = false;

      Vector2 deployLinearVelocity = Vector2(0, 1.5);
      body.linearVelocity = deployLinearVelocity;
      return;
    }

    close();
  }

  void close() {
    stop();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (isLeft && body.angle > -12.3) {
        body.angularVelocity = _getAngularVelocity();
      }

      if (!isLeft && body.angle < 12.3) {
        body.angularVelocity = _getAngularVelocity();
      }
    });

    Future.delayed(const Duration(seconds: 2), () => refold());
  }

  void stop() {
    body.linearVelocity = Vector2.zero();
  }

  void refold() {
    isDeploying = false;
    isRefolding = true;
    body.linearVelocity = Vector2(0, -1.5);
  }

  double _getAngle() {
    return isLeft ? -11.4 : 11.4;
  }

  Shape _createShape() {
    if (isLeft) {
      return ChainShape()
        ..createChain([
          Vector2(0, 0),
          Vector2(-1 / 2, 1.2 / 2),
          Vector2(0, 2.2 / 2),
          Vector2(0.5 / 2, 2.1 / 2),
        ]);
    }

    return ChainShape()
      ..createChain([
        Vector2(0, 0),
        Vector2(1 / 2, 1.2 / 2),
        Vector2(0, 2.2 / 2),
        Vector2(-0.5 / 2, 2.1 / 2),
      ]);
  }

  double _getAngularVelocity() {
    return isLeft ? -1 : 1;
  }
}
