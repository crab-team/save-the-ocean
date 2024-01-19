import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';
import 'package:save_the_ocean/game.dart';

class GarbageComponent extends BodyComponent {
  final Garbage garbage;

  GarbageComponent({required this.garbage});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      angle: 1,
      position: Vector2(0.5, worldSize.y - 4),
      gravityScale: Vector2(0.5, 0.2),
      linearVelocity: Vector2(garbage.initialLinearVelocityX, 0),
      angularVelocity: garbage.initialAngularVelocity,
    );

    final fixtureDef = FixtureDef(
      garbage.shape,
      userData: this,
      restitution: garbage.restitution,
      friction: garbage.friction,
      density: garbage.density,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
  }
}
