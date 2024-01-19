import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/garbage/garbage.dart';
import 'package:save_the_ocean/components/robot/robot_controller.dart';
import 'package:save_the_ocean/game.dart';

class RobotClaw extends BodyComponent with ContactCallbacks {
  final bool isLeft;

  RobotClaw({required this.isLeft});

  late RobotController _robotController;
  RobotState robotState = RobotState.idle;
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
      density: 1,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
    _robotController = RobotController(this);
  }

  @override
  void update(double dt) {
    super.update(dt);
    getWeightLoad();
    _robotController.bounds();
    _robotController.moveInXAxis();
    _robotController.openCloseClaws();
    // kDebugMode ? _robotController.logger() : null;
  }

  void getWeightLoad() {
    weightLoad = garbageCollected.fold(0, (previousValue, element) => previousValue + element.mass);
  }

  void idle() => robotState = RobotState.idle;
  void deploy() {
    bool canDeploy = robotState == RobotState.idle && robotClawState == RobotClawState.open;
    if (canDeploy) _robotController.executeDeploy();
  }

  void refold() {
    bool canRefold = robotState == RobotState.deployed && robotClawState == RobotClawState.open;
    if (canRefold) _robotController.executeRefold();
  }

  double getAngle() {
    return isLeft ? -11.4 : 11.4;
  }

  Shape _createShape() {
    if (isLeft) {
      return ChainShape()
        ..createChain([
          Vector2(0, 0),
          Vector2(-1 / 2, 1.2 / 2),
          Vector2(0, 2.2 / 2),
          Vector2(0.5 / 2, 2.1 / 2),
        ]);
    }

    return ChainShape()
      ..createChain([
        Vector2(0, 0),
        Vector2(1 / 2, 1.2 / 2),
        Vector2(0, 2.2 / 2),
        Vector2(-0.5 / 2, 2.1 / 2),
      ]);
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is Garbage) {
      Body garbage = other.body;
      garbageCollected.add(garbage);
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    super.endContact(other, contact);

    if (other is Garbage) {
      Body garbage = other.body;
      garbageCollected.remove(garbage);
    }
  }
}
