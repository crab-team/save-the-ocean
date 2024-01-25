import 'package:flame/components.dart';
import 'package:save_the_ocean/components/hub/robot_release_joystick.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/game.dart';

enum RobotClawState {
  opening,
  open,
  closing,
  close,
}

class RobotController {
  RobotController(this.robot);

  final RobotClaw robot;

  double linearVelocity = 2.8;
  double angularVelocity = 3;

  void moveInXAxis() {
    robotPositionNotifier.addListener(() {
      robot.body.linearVelocity = Vector2(robotPositionNotifier.velocity, 0);
    });
  }

  void deployListener() {
    robotDeployNotifier.addListener(() {
      robotDeployNotifier.deploy ? executeDeploy() : executeRefold();
    });
  }

  bool get deployLimits => robot.body.position.x >= 1.6 && robot.body.position.x <= worldSize.x - 1.5;

  void executeDeploy() {
    if (deployLimits) {
      Vector2 deployLinearVelocity = Vector2(0, linearVelocity);
      robot.body.linearVelocity = deployLinearVelocity;
      return;
    }
  }

  void executeRefold() {
    Vector2 refoldLinearVelocity = Vector2(0, -linearVelocity);
    robot.body.linearVelocity = refoldLinearVelocity;
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
