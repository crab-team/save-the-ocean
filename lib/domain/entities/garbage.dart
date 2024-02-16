import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/constants/assets.dart';

enum GarbageType {
  battery,
  tools,
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
  final String? spriteSheet;
  final Vector2 size;
  final bool? isAnimated;

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
    this.isAnimated = false,
    this.spriteSheet,
  });

  factory Garbage.battery() {
    return Garbage(
      initialLinearVelocityX: 3,
      initialAngularVelocity: 2,
      type: GarbageType.battery,
      friction: 1,
      restitution: 0.2,
      density: 1,
      sprite: ArtboardNames.battery,
      shape: PolygonShape()..setAsBoxXY(0.2, 0.5),
      size: Vector2(0.8, 1.2),
      isAnimated: true,
    );
  }

  factory Garbage.tools() {
    return Garbage(
      initialLinearVelocityX: 2,
      initialAngularVelocity: 1,
      type: GarbageType.tools,
      friction: 0.5,
      restitution: 0.5,
      density: 0.8,
      sprite: ImageAssets.tools,
      spriteSheet: AnimationAssets.tools,
      shape: PolygonShape()..setAsBoxXY(0.4, 0.4),
      size: Vector2(1.2, 1),
      isAnimated: true,
    );
  }

  factory Garbage.bottle() {
    return Garbage(
      initialLinearVelocityX: 2,
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
