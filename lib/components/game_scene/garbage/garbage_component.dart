import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_animated_sprite.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_rive_component.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_sprite.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class GarbageComponent extends BodyComponent implements PositionProvider {
  final Garbage garbage;

  GarbageComponent({required this.garbage});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      angle: 1,
      position: Vector2(0.5, worldSize.y * 0.4),
      gravityScale: Vector2(0.5, 0.2),
      linearVelocity: Vector2(garbage.initialLinearVelocityX * 1.5, 0),
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
    renderBody = false;
    if (garbage.isAnimated == true) {
      final spriteAnimated = GarbageSpriteAnimation(
        spriteSheet: garbage.spriteSheet!,
        sprite: garbage.sprite,
        spriteSize: garbage.size,
        spritePosition: Vector2(0, 0),
      );
      // spriteAnimated.position = Vector2(0, 0);
      // spriteAnimated.size = garbage.size;
      // spriteAnimated.anchor = Anchor.center;
      add(spriteAnimated);
      return;
    }

    final sprite = GarbageSpriteComponent(path: garbage.sprite);
    sprite.size = garbage.size;
    add(sprite);
  }

  @override
  set position(Vector2 value) {
    body.setTransform(value, angle);
  }
}
