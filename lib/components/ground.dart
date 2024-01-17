import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/game.dart';

class Ground extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(0, worldSize.y - 1.4),
      type: BodyType.static,
    );

    final shape = EdgeShape()..set(Vector2.zero(), Vector2(worldSize.x - 2, 0));
    final fixtureDef = FixtureDef(shape, density: 1, friction: 0.7);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
