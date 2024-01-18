import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
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

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(initialPositionX, initialPositionY),
      angle: _getAngle(),
      linearDamping: 0.9,
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

    _robotController.bounds();
    _robotController.moveInXAxis();
    _robotController.executeDeploy();
    _robotController.executeOpen();
    _robotController.executeRefold();
    kDebugMode ? _robotController.logger() : null;
  }

  void idle() => robotState = RobotState.idle;
  void deploy() {
    bool canDeploy = robotState == RobotState.idle && robotClawState == RobotClawState.open;
    if (canDeploy) robotState = RobotState.deploying;
  }

  void refold() {
    bool canRefold = robotState == RobotState.deployed && robotClawState == RobotClawState.open;
    if (canRefold) robotState = RobotState.refolding;
  }

  void open() {
    bool canOpen = robotClawState == RobotClawState.close;
    if (canOpen) robotClawState = RobotClawState.opening;
  }

  void close() {
    if (robotClawState == RobotClawState.open) {
      robotClawState = RobotClawState.closing;
    }
  }

  double _getAngle() {
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
}
