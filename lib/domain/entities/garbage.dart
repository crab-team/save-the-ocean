import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/constants/assets.dart';

enum GarbageType {
  banana,
  bottle,
  paper,
  plasticBag,
  tire,
}

class Garbage {
  final double initialLinearVelocityX;
  final double initialAngularVelocity;
  final GarbageType type;
  final double friction;
  final double restitution;
  final double density;
  final Shape shape;
  final String? sprite;

  Garbage({
    required this.type,
    required this.initialLinearVelocityX,
    required this.initialAngularVelocity,
    required this.friction,
    required this.restitution,
    required this.density,
    required this.shape,
    this.sprite,
  });

  factory Garbage.banana() {
    return Garbage(
      initialLinearVelocityX: 2,
      initialAngularVelocity: 1,
      type: GarbageType.banana,
      friction: 0.8,
      restitution: 0.2,
      density: 0.5,
      shape: PolygonShape()..setAsBoxXY(0.05, 0.2),
    );
  }

  factory Garbage.bottle() {
    return Garbage(
      initialLinearVelocityX: 1,
      initialAngularVelocity: 2,
      type: GarbageType.bottle,
      friction: 0.2,
      restitution: 0.8,
      density: 0.1,
      shape: PolygonShape()..setAsBoxXY(0.1, 0.2),
      sprite: ImageAssets.bottle,
    );
  }

  factory Garbage.paper() {
    return Garbage(
        initialLinearVelocityX: 2,
        initialAngularVelocity: 0,
        type: GarbageType.paper,
        friction: 0.2,
        restitution: 0,
        density: 0.4,
        shape: PolygonShape()..setAsBoxXY(0.1, 0.2));
  }

  factory Garbage.plasticBag() {
    return Garbage(
        initialLinearVelocityX: 2,
        initialAngularVelocity: 0,
        type: GarbageType.plasticBag,
        friction: 1,
        restitution: 0,
        density: 0.1,
        shape: PolygonShape()..setAsBoxXY(0.1, 0.1));
  }

  factory Garbage.tire() {
    return Garbage(
      initialLinearVelocityX: 3,
      initialAngularVelocity: 1,
      type: GarbageType.tire,
      friction: 0.8,
      restitution: 0.4,
      density: 0.8,
      shape: CircleShape()..radius = 0.3,
    );
  }
}
