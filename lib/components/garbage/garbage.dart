import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/game.dart';

class Garbage extends BodyComponent {
  final double initialLinearVelocityX;
  final double initialAngularVelocity;

  Garbage({
    required this.initialLinearVelocityX,
    required this.initialAngularVelocity,
  });

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(0.5, worldSize.y - 4),
      type: BodyType.dynamic,
      angle: 1,
      linearVelocity: Vector2(initialLinearVelocityX, 0),
      angularVelocity: initialAngularVelocity,
      gravityScale: Vector2(0.5, 0.2),
    );

    final shape = PolygonShape()..setAsBoxXY(0.1, 0.2);

    final fixtureDef = FixtureDef(
      shape,
      userData: this,
      restitution: 0,
      friction: 0.8,
      density: 0.3,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
  }
}
