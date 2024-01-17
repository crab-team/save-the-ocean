import 'package:flame/components.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

enum RobotState {
  idle,
  deploying,
  deployed,
  refolding,
  opening,
  open,
  closing,
  close,
  movingLeft,
  movingRight,
  outOfBounds,
}

class RobotController {
  RobotController(this.robot);

  final RobotClaw robot;

  void moveInXAxis() {
    bool joystickLeft = joystick.direction == JoystickDirection.left;
    bool joystickRight = joystick.direction == JoystickDirection.right;

    if (joystickLeft && robot.state == RobotState.idle) {
      robot.body.linearVelocity = Vector2(-4 * joystick.intensity, 0);
    }

    if (joystickRight && robot.state == RobotState.idle) {
      robot.body.linearVelocity = Vector2(4 * joystick.intensity, 0);
    }
  }

  void executeDeploy() {
    if (robot.state == RobotState.deploying) {
      Vector2 deployLinearVelocity = Vector2(0, 1.8);
      robot.body.linearVelocity = deployLinearVelocity;
      robot.state = RobotState.deployed;
      return;
    }
  }

  void executeOpen() {
    if (robot.state == RobotState.opening) {
      robot.body.angularVelocity = robot.isLeft ? 1 : -1;
      Future.delayed(const Duration(milliseconds: 900), () {
        robot.body.angularVelocity = 0;
        robot.state = RobotState.idle;
      });
      return;
    }
  }

  void _close() {
    robot.body.angularVelocity = robot.isLeft ? -1 : 1;
    Future.delayed(const Duration(milliseconds: 900), () {
      robot.body.angularVelocity = 0;
      robot.state = RobotState.close;
    });
  }

  void executeRefold() {
    if (robot.state == RobotState.refolding) {
      _close();
      Future.delayed(const Duration(milliseconds: 900), () {
        Vector2 refoldLinearVelocity = Vector2(0, -1.8);
        robot.body.linearVelocity = refoldLinearVelocity;
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
    if (robot.body.position.x >= worldSize.x - 1.6 && robot.body.linearVelocity.x > 0) {
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
