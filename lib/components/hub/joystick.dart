import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:save_the_ocean/components/hub/battery_level_rive_component.dart';
import 'package:save_the_ocean/components/game_scene/pollution_water/pollution_water_rive_component.dart';
import 'package:save_the_ocean/components/hub/robot_deploy_button.dart';
import 'package:save_the_ocean/components/hub/robot_release_trash_button.dart';
import 'package:save_the_ocean/components/hub/rudder_joystick/rudder_joystick.dart';
import 'package:save_the_ocean/game.dart';

class JoystickFactory {
  static Joystick create() {
    final hub = Joystick();
    final effect =
        MoveEffect.to(Vector2(0, screenSize.y - hub.size.y), EffectController(duration: 2, curve: Curves.easeOutCubic));
    hub.add(effect);
    return hub;
  }
}

class Joystick extends PositionComponent with HasGameRef<SaveTheOceanGame> {
  Joystick()
      : super(
          size: Vector2(screenSize.x, screenSize.y),
          position: Vector2(0, 0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await initBatteryLevel();
    initRudderJoystick();
    initRobotDeployButton();
    initReleaseTrashButton();
  }

  Future<void> initBatteryLevel() async {
    final batteryLevelComponent = await BatteryLevelRiveComponentFactory.create();
    batteryLevelComponent.size = Vector2(700, 120);
    batteryLevelComponent.position = Vector2(100, 40);
    add(batteryLevelComponent);
  }

  void initRudderJoystick() {
    final rudderJoystick = RudderJoystick();
    rudderJoystick.size = Vector2(size.x / 5, size.y);
    rudderJoystick.position = Vector2(100, size.y - 1);
    add(rudderJoystick);
  }

  void initRobotDeployButton() {
    final robotDeployButton = RobotDeployButton();
    robotDeployButton.position =
        Vector2(size.x - robotDeployButton.size.x - 220, size.y - robotDeployButton.size.y - 30);
    add(robotDeployButton);
  }

  void initReleaseTrashButton() {
    final releaseTrashButton = RobotReleaseTrashButton();
    releaseTrashButton.position =
        Vector2(size.x - releaseTrashButton.size.x - 60, size.y - releaseTrashButton.size.y - 200);
    add(releaseTrashButton);
  }
}
