import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class WallComponent extends BodyComponent {
  final bool isLeft;
  late PolygonShape shape;

  WallComponent({required this.isLeft});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(isLeft ? 0 : worldSize.x, 0),
      type: BodyType.static,
      gravityScale: Vector2(0, 0),
    );

    if (isLeft) {
      shape = PolygonShape()
        ..set([
          Vector2(0, 2),
          Vector2(0.4, 2),
          Vector2(0.25, 3),
          Vector2(0.2, 3),
          Vector2(0.3, worldSize.y),
          Vector2(0, worldSize.y),
        ]);
    } else {
      shape = PolygonShape()
        ..set([
          Vector2(0, 2),
          Vector2(-0.4, 2),
          Vector2(-0.3, 3),
          Vector2(-0.3, 3),
          Vector2(-0.2, worldSize.y),
          Vector2(0, worldSize.y),
        ]);
    }

    final fixtureDef = FixtureDef(shape, friction: 0.9, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
