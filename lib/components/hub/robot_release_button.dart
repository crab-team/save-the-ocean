import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/components/robot/robot_controller.dart';

class RobotReleaseButton extends HudButtonComponent {
  final Robot robot;
  final RobotClaw leftClaw;
  final RobotClaw rightClaw;

  @override
  Future<void> onLoad() {
    debugMode = kDebugMode;
    return super.onLoad();
  }

  RobotReleaseButton({required this.robot, required this.leftClaw, required this.rightClaw})
      : super(
          button: CircleComponent(
            radius: 40,
            paint: BasicPalette.gray.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 40,
            paint: BasicPalette.darkRed.paint(),
          ),
          margin: const EdgeInsets.only(right: 48, bottom: 32),
          onPressed: () {
            leftClaw.open();
            rightClaw.open();
          },
        );

  @override
  void update(double dt) {
    super.update(dt);
    super.button = CircleComponent(
      radius: 40,
      paint: leftClaw.robotClawState == RobotClawState.close && leftClaw.robotState == RobotState.idle
          ? BasicPalette.green.paint()
          : BasicPalette.gray.paint(),
    );
  }
}
