import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/game.dart';

class Garbage extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(worldSize.x / 2, worldSize.y / 2),
      type: BodyType.dynamic,
    );

    final shape = CircleShape()..radius = 0.2;

    final fixtureDef = FixtureDef(
      shape,
      userData: this,
      restitution: 0.75,
      friction: 0.1,
      density: 0.1,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
