import 'package:flame/effects.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/widgets.dart';
import 'package:save_the_ocean/game.dart';

class WallComponentFactory {
  static WallComponent create(bool isLeft) {
    final wall = WallComponent(isLeft: isLeft);

    double finalPositionX = isLeft ? 0 : worldSize.x;
    final effect = MoveEffect.to(
      Vector2(finalPositionX, 0),
      EffectController(duration: 2, curve: Curves.easeOutCubic),
    );
    wall.add(effect);
    return wall;
  }
}

class WallComponent extends BodyComponent implements PositionProvider {
  final bool isLeft;
  late PolygonShape shape;

  WallComponent({required this.isLeft});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(isLeft ? -1 : worldSize.x + 1, 0),
      type: BodyType.static,
      gravityScale: Vector2(0, 0),
    );

    if (isLeft) {
      shape = PolygonShape()
        ..set([
          Vector2(0, 1),
          Vector2(0.4, 2),
          Vector2(0.3, 3),
          Vector2(0.5, 3),
          Vector2(0.7, worldSize.y),
          Vector2(0, worldSize.y),
        ]);
    } else {
      shape = PolygonShape()
        ..set([
          Vector2(0, 1),
          Vector2(-0.4, 2),
          Vector2(-0.3, 3),
          Vector2(-0.5, 3),
          Vector2(-0.7, worldSize.y),
          Vector2(0, worldSize.y),
        ]);
    }

    final fixtureDef = FixtureDef(shape, friction: 0.9, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  set position(Vector2 value) {
    body.setTransform(value, angle);
  }
}
