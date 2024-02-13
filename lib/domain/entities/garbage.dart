import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/constants/assets.dart';

enum GarbageType {
  battery,
  bottle,
  plastic,
  beer,
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
  final String sprite;
  final Vector2 size;

  Garbage({
    required this.type,
    required this.initialLinearVelocityX,
    required this.initialAngularVelocity,
    required this.friction,
    required this.restitution,
    required this.density,
    required this.shape,
    required this.sprite,
    required this.size,
  });

  factory Garbage.battery() {
    return Garbage(
      initialLinearVelocityX: 2,
      initialAngularVelocity: 1,
      type: GarbageType.battery,
      friction: 0.8,
      restitution: 0.2,
      density: 0.5,
      sprite: ImageAssets.battery,
      shape: PolygonShape()..setAsBoxXY(0.15, 0.3),
      size: Vector2(0.4, 0.7),
    );
  }

  factory Garbage.bottle() {
    return Garbage(
      initialLinearVelocityX: 1,
      initialAngularVelocity: 2,
      type: GarbageType.bottle,
      friction: 0.2,
      restitution: 0.3,
      density: 0.1,
      shape: PolygonShape()..setAsBoxXY(0.1, 0.4),
      sprite: ImageAssets.bottle,
      size: Vector2(0.4, 0.8),
    );
  }

  factory Garbage.plastic() {
    return Garbage(
      initialLinearVelocityX: 2,
      initialAngularVelocity: 0,
      type: GarbageType.plastic,
      friction: 0.2,
      restitution: 0.1,
      density: 0.4,
      sprite: ImageAssets.plastic,
      shape: PolygonShape()..setAsBoxXY(0.3, 0.2),
      size: Vector2(0.7, 0.5),
    );
  }

  factory Garbage.beer() {
    return Garbage(
      initialLinearVelocityX: 2,
      initialAngularVelocity: 0,
      type: GarbageType.beer,
      friction: 0.9,
      restitution: 0,
      density: 0.3,
      sprite: ImageAssets.beer,
      shape: PolygonShape()..setAsBoxXY(0.15, 0.3),
      size: Vector2(0.5, 0.7),
    );
  }

  factory Garbage.tire() {
    return Garbage(
      initialLinearVelocityX: 3,
      initialAngularVelocity: 1,
      type: GarbageType.tire,
      friction: 0.5,
      restitution: 0.5,
      density: 0.8,
      sprite: ImageAssets.tire,
      shape: CircleShape()..radius = 0.5,
      size: Vector2(1, 1),
    );
  }
}
