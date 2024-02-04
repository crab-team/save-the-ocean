import 'package:flame/effects.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/garbage/garbage_sprite.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';
import 'package:save_the_ocean/game.dart';

class GarbageComponent extends BodyComponent implements PositionProvider {
  final Garbage garbage;

  GarbageComponent({required this.garbage});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      angle: 1,
      position: Vector2(0.5, worldSize.y - 4),
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
    if (garbage.sprite != null) {
      final sprite = GarbageSpriteComponent(path: garbage.sprite!);
      sprite.size = Vector2(0.25, 0.45);
      add(sprite);
    }
  }

  @override
  set position(Vector2 value) {
    body.setTransform(value, angle);
  }
}
