import 'package:flame/components.dart';
import 'package:save_the_ocean/components/robot/robot_arm_component.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/screens/game_screen.dart';

enum RobotClawState {
  opening,
  open,
  closing,
  close,
}

class RobotController {
  final RobotClaw leftRobotClaw;
  final RobotClaw rightRobotClaw;
  final RobotArmComponent robotArm;

  RobotController({required this.leftRobotClaw, required this.rightRobotClaw, required this.robotArm});

  double linearVelocity = 6;
  double angularVelocity = 3;
  bool release = false;

  void moveInXAxis() {
    robotPositionNotifier.addListener(() {
      leftRobotClaw.body.linearVelocity = Vector2(robotPositionNotifier.velocity, 0);
      rightRobotClaw.body.linearVelocity = Vector2(robotPositionNotifier.velocity, 0);
      robotArm.body.linearVelocity = Vector2(robotPositionNotifier.velocity, 0);
    });
  }

  void deployListener() {
    robotDeployNotifier.addListener(() {
      robotDeployNotifier.deploy ? executeDeploy() : executeRefold();
    });
  }

  void releaseListener() {
    robotReleaseTrashNotifier.addListener(() {
      release = robotReleaseTrashNotifier.released;
    });
  }

  void executeDeploy() {
    Vector2 deployLinearVelocity = Vector2(0, linearVelocity);
    leftRobotClaw.body.linearVelocity = deployLinearVelocity;
    rightRobotClaw.body.linearVelocity = deployLinearVelocity;
    robotArm.body.linearVelocity = deployLinearVelocity;
    return;
  }

  void executeRefold() {
    Vector2 refoldLinearVelocity = Vector2(0, -linearVelocity);
    leftRobotClaw.body.linearVelocity = refoldLinearVelocity;
    rightRobotClaw.body.linearVelocity = refoldLinearVelocity;
    robotArm.body.linearVelocity = refoldLinearVelocity;
  }

  void openClaws() {
    if (release) {
      if (leftRobotClaw.body.angle < -11) {
        leftRobotClaw.body.angularVelocity = angularVelocity;
      } else {
        leftRobotClaw.body.angularVelocity = 0;
      }

      if (rightRobotClaw.body.angle > 11) {
        rightRobotClaw.body.angularVelocity = -angularVelocity;
      } else {
        rightRobotClaw.body.angularVelocity = 0;
      }
    }
  }

  void closeClaws() {
    if (!release) {
      if (leftRobotClaw.body.angle > -12.3) {
        leftRobotClaw.body.angularVelocity = -angularVelocity;
      } else {
        leftRobotClaw.body.angularVelocity = 0;
      }

      if (rightRobotClaw.body.angle < 12.3) {
        rightRobotClaw.body.angularVelocity = angularVelocity;
      } else {
        rightRobotClaw.body.angularVelocity = 0;
      }
    }
  }

  void _stop() {
    leftRobotClaw.body.linearVelocity = Vector2.zero();
    rightRobotClaw.body.linearVelocity = Vector2.zero();
    robotArm.body.linearVelocity = Vector2.zero();
  }

  void bounds() {
    // Limite contra muro izquierdo
    if (leftRobotClaw.body.position.x < 1.6 && leftRobotClaw.body.linearVelocity.x < 0) {
      _stop();
    }

    // Limite contra muro derecho
    if (leftRobotClaw.body.position.x >= worldSize.x - 1.5 && leftRobotClaw.body.linearVelocity.x > 0) {
      _stop();
    }

    // Limite contra el suelo
    if (leftRobotClaw.body.position.y > worldSize.y - 3.9 && leftRobotClaw.body.linearVelocity.y > 0) {
      _stop();
    }

    // Limite contra el techo
    if (leftRobotClaw.body.position.y < 1 && leftRobotClaw.body.linearVelocity.y < 0) {
      _stop();
    }
  }
}
