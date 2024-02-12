import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class GroundSpriteComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  GroundSpriteComponent()
      : super(
          size: Vector2(worldSize.x, worldSize.y),
          anchor: Anchor.bottomLeft,
          position: Vector2(0, 2.3),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = gameRef.debugMode;
    sprite = Sprite(gameRef.images.fromCache(ImageAssets.level));
  }
}

class GroundBodyComponent extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(0, worldSize.y - 2.3),
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
}
