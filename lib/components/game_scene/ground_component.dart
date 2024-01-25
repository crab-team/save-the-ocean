import 'package:flame/effects.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/widgets.dart';
import 'package:save_the_ocean/game.dart';

class GroundBodyComponentFactory {
  static GroundBodyComponent create() {
    final ground = GroundBodyComponent();
    final effect = MoveEffect.to(
      Vector2(0, worldSize.y - 1.5),
      EffectController(duration: 2, curve: Curves.easeOutCubic),
    );
    ground.add(effect);
    return ground;
  }
}

class GroundBodyComponent extends BodyComponent implements PositionProvider {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(0, worldSize.y),
      type: BodyType.static,
    );

    final shape = ChainShape()
      ..createChain([
        Vector2.zero(),
        Vector2(worldSize.x - 2, 0),
        Vector2(worldSize.x - 2, -3),
      ]);
    final fixtureDef = FixtureDef(shape, density: 1, friction: 0.7);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  set position(Vector2 value) {
    body.setTransform(value, angle);
  }
}
