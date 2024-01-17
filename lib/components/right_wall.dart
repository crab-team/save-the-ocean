import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/game.dart';

class RightWall extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x, 0),
      type: BodyType.static,
    );

    final shape = PolygonShape()
      ..set([
        Vector2(0, 1),
        Vector2(-0.4, 2),
        Vector2(-0.3, 3),
        Vector2(-0.5, 3),
        Vector2(-0.7, worldSize.y),
        Vector2(0, worldSize.y),
      ]);
    final fixtureDef = FixtureDef(shape, friction: 0.9, density: 1, userData: this);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
