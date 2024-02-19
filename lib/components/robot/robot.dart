import 'dart:async';

import 'package:flame/components.dart';
import 'package:save_the_ocean/components/robot/robot_arm_component.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/components/robot/robot_controller.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class Robot extends PositionComponent with HasGameRef<SaveTheOceanGame> {
  late RobotController _robotController;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final arm = RobotArmComponent();
    final leftClaw = RobotClaw(isLeft: true);
    final rightClaw = RobotClaw(isLeft: false);
    add(leftClaw);
    add(rightClaw);
    add(arm);

    _robotController = RobotController(leftRobotClaw: leftClaw, rightRobotClaw: rightClaw, robotArm: arm);

    _robotController.moveInXAxis();
    _robotController.deployListener(gameRef);
    _robotController.releaseListener();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _robotController.bounds();
    _robotController.openClaws();
    _robotController.closeClaws();
  }
}
