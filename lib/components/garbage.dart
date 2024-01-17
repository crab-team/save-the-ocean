import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/game.dart';

class Garbage extends BodyComponent {
  final double initialLinearVelocityX;
  final double initialAngularVelocity;
  final bool fromLeft;

  Garbage({
    required this.initialLinearVelocityX,
    required this.initialAngularVelocity,
    required this.fromLeft,
  });

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(fromLeft ? 0.1 : worldSize.x - 0.1, 1),
      type: BodyType.dynamic,
      linearVelocity: Vector2(fromLeft ? initialLinearVelocityX : (initialLinearVelocityX * -1) - 2, 0),
      angularVelocity: initialAngularVelocity,
      gravityScale: Vector2(0.5, 0.2),
    );

    final shape = PolygonShape()..setAsBoxXY(0.1, 0.2);

    final fixtureDef = FixtureDef(
      shape,
      userData: this,
      restitution: 0,
      friction: 0.8,
      density: 0.3,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
