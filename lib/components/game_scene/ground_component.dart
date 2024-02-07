import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/widgets.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class GroundBodyComponentFactory {
  static GroundBodyComponent create() {
    final ground = GroundBodyComponent();
    final effect = MoveEffect.to(
      Vector2(0, worldSize.y - 2),
      EffectController(duration: 2, curve: Curves.easeOutCubic),
    );
    ground.add(effect);
    return ground;
  }
}

class GroundSpriteComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  GroundSpriteComponent()
      : super(
          size: Vector2(worldSize.x, worldSize.y),
          anchor: Anchor.topLeft,
          position: Vector2(0, -worldSize.y + 2.33),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = gameRef.debugMode;
    sprite = Sprite(gameRef.images.fromCache(ImageAssets.level));
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
        Vector2(worldSize.x - 5.8, 0),
        Vector2(worldSize.x - 5.8, -4.5),
      ]);
    final fixtureDef = FixtureDef(shape, density: 1, friction: 0.7);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final groundSprite = GroundSpriteComponent();
    add(groundSprite);
  }

  @override
  set position(Vector2 value) {
    body.setTransform(value, angle);
  }
}
