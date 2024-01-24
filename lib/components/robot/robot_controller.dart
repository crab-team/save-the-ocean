import 'package:flame/components.dart';
import 'package:save_the_ocean/components/hub/robot_release_joystick.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/game.dart';

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

  double linearVelocity = 2.8;
  double angularVelocity = 3;

  void moveInXAxis() {
    robotNotifier.addListener(() {
      robot.body.linearVelocity = Vector2(robotNotifier.velocity, 0);
    });
  }

  bool get deployLimits => robot.body.position.x >= 1.6 && robot.body.position.x <= worldSize.x - 1.5;

  void executeDeploy() {
    if (robot.robotState == RobotState.idle && robot.robotClawState == RobotClawState.open && deployLimits) {
      robot.robotState = RobotState.deploying;
      Vector2 deployLinearVelocity = Vector2(0, linearVelocity);
      robot.body.linearVelocity = deployLinearVelocity;
      robot.robotState = RobotState.deployed;
      return;
    }
  }

  void executeRefold() {
    Vector2 refoldLinearVelocity = Vector2(0, -linearVelocity);
    robot.body.linearVelocity = refoldLinearVelocity;
    if (robot.body.position.y >= robot.initialPositionY) {
      robot.robotState = RobotState.idle;
    }
  }

  void openCloseClaws() {
    bool joystickUp = robotReleaseJoystick.direction == JoystickDirection.up;
    bool joystickDown = robotReleaseJoystick.direction == JoystickDirection.down;
    bool joystickIsMoving = robotReleaseJoystick.isDragged;

    if (joystickUp) {
      if (robot.body.angle < -10.5 && robot.isLeft && joystickIsMoving) {
        robot.body.angularVelocity = angularVelocity * robotReleaseJoystick.intensity;
        return;
      }

      if (robot.body.angle > 10.5 && !robot.isLeft && joystickIsMoving) {
        robot.body.angularVelocity = -angularVelocity * robotReleaseJoystick.intensity;
        return;
      }

      robot.body.angularVelocity = 0;
      return;
    }

    if (joystickDown) {
      if (robot.body.angle > -12.3 && robot.isLeft && joystickIsMoving) {
        robot.body.angularVelocity = -angularVelocity * robotReleaseJoystick.intensity;
        return;
      }

      if (robot.body.angle < 12.3 && !robot.isLeft && joystickIsMoving) {
        robot.body.angularVelocity = angularVelocity * robotReleaseJoystick.intensity;
        return;
      }

      robot.body.angularVelocity = 0;
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
