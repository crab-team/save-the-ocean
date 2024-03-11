import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_component.dart';
import 'package:save_the_ocean/components/robot/robot_claw_sprite_component.dart';
import 'package:save_the_ocean/components/robot/robot_controller.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class RobotClaw extends BodyComponent with ContactCallbacks {
  final bool isLeft;

  RobotClaw({required this.isLeft});

  RobotClawState robotClawState = RobotClawState.open;
  double initialPositionX = worldSize.x / 2;
  double initialPositionY = 1;
  List<Body> garbageCollected = [];
  double weightLoad = 0;

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(initialPositionX, initialPositionY),
      angle: getAngle(),
      type: BodyType.kinematic,
    );

    final shape = _createShape();
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.9,
      density: 0.5,
      restitution: 0.1,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _initSprites();
  }

  void _initSprites() {
    RobotClawSpriteComponent robotClawSpriteComponent = RobotClawSpriteComponent();
    if (isLeft) {
      robotClawSpriteComponent.x = -0.4;
      robotClawSpriteComponent.y = 0.15;
      robotClawSpriteComponent.angle = -0.2;
    } else {
      robotClawSpriteComponent.x = 0.4;
      robotClawSpriteComponent.y = 0.15;
      robotClawSpriteComponent.angle = 0.2;
      robotClawSpriteComponent.flipHorizontally();
    }
    add(robotClawSpriteComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    getWeightLoad();
  }

  void getWeightLoad() {
    weightLoad = garbageCollected.fold(0, (previousValue, element) => previousValue + element.mass);
  }

  double getAngle() {
    return isLeft ? -11.4 : 11.4;
  }

  Shape _createShape() {
    if (isLeft) {
      return ChainShape()
        ..createChain([
          Vector2(0, 0),
          Vector2(-1 * 0.7, 1.2 * 0.7),
          Vector2(0, 2.2 * 0.7),
          Vector2(0.43 * 0.7, 2.1 * 0.7),
        ]);
    }

    return ChainShape()
      ..createChain([
        Vector2(0, 0),
        Vector2(1 * 0.7, 1.2 * 0.7),
        Vector2(0, 2.2 * 0.7),
        Vector2(-0.43 * 0.7, 2.1 * 0.7),
      ]);
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is GarbageComponent) {
      Body garbage = other.body;
      garbageCollected.add(garbage);
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    super.endContact(other, contact);

    if (other is GarbageComponent) {
      Body garbage = other.body;
      garbageCollected.remove(garbage);
    }
  }
}
