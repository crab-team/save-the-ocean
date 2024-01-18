import 'package:flame/components.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

enum RobotState {
  idle,
  deploying,
  deployed,
  refolding,
  outOfBounds,
}

enum RobotClawState {
  opening,
  open,
  closing,
  close,
}

class RobotController {
  RobotController(this.robot);

  final RobotClaw robot;

  void logger() {
    print('Robot State: ${robot.robotState}');
    print('Robot Claw State: ${robot.robotClawState}');
  }

  void moveInXAxis() {
    bool joystickLeft = joystick.direction == JoystickDirection.left;
    bool joystickRight = joystick.direction == JoystickDirection.right;

    if (joystickLeft && robot.robotState == RobotState.idle) {
      robot.body.linearVelocity = Vector2(-4 * joystick.intensity, 0);
    }

    if (joystickRight && robot.robotState == RobotState.idle) {
      robot.body.linearVelocity = Vector2(4 * joystick.intensity, 0);
      robot.body.angularDamping = 0.5;
    }
  }

  void executeDeploy() {
    if (robot.robotState == RobotState.idle && robot.robotClawState == RobotClawState.open) {
      robot.robotState = RobotState.deploying;
      Vector2 deployLinearVelocity = Vector2(0, 1.8);
      robot.body.linearVelocity = deployLinearVelocity;
      robot.robotState = RobotState.deployed;
      return;
    }
  }

  void executeOpen() {
    if (robot.robotClawState == RobotClawState.opening && robot.robotState == RobotState.idle) {
      robot.body.angularVelocity = robot.isLeft ? 1 : -1;
      Future.delayed(const Duration(milliseconds: 900), () {
        robot.body.angularVelocity = 0;
        robot.robotClawState = RobotClawState.open;
      });
      return;
    }
  }

  void _close() {
    robot.body.angularVelocity = robot.isLeft ? -1 : 1;
    Future.delayed(const Duration(milliseconds: 900), () {
      robot.body.angularVelocity = 0;
      robot.robotClawState = RobotClawState.close;
    });
  }

  void executeRefold() {
    if (robot.robotState == RobotState.refolding) {
      _close();
      Future.delayed(const Duration(milliseconds: 900), () {
        // double resistance = robot.weightLoad * 20;
        // print('resistance $resistance');
        Vector2 refoldLinearVelocity = Vector2(0, -1.8);
        robot.body.linearVelocity = refoldLinearVelocity;
        if (robot.body.position.y >= robot.initialPositionY) {
          robot.robotState = RobotState.idle;
        }
      });
      return;
    }
  }

  void _stop() {
    robot.body.linearVelocity = Vector2.zero();
  }

  void bounds() {
    // Limite contra muro izquierdo
    if (robot.body.position.x < 1.6 && robot.body.linearVelocity.x < 0) {
      _stop();
    }

    // Limite contra muro derecho
    if (robot.body.position.x >= worldSize.x - 1.5 && robot.body.linearVelocity.x > 0) {
      _stop();
    }

    // Limite contra el suelo
    if (robot.body.position.y > worldSize.y - 2.5 && robot.body.linearVelocity.y > 0) {
      _stop();
    }

    // Limite contra el techo
    if (robot.body.position.y < 1 && robot.body.linearVelocity.y < 0) {
      _stop();
    }
  }
}
