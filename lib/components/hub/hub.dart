import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:save_the_ocean/components/hub/battery_level_rive_component.dart';
import 'package:save_the_ocean/components/hub/pollution_level_rive_component.dart';
import 'package:save_the_ocean/components/hub/robot_release_trash_button.dart';
import 'package:save_the_ocean/components/hub/robot_deploy_button.dart';
import 'package:save_the_ocean/components/hub/rudder_joystick/rudder_joystick.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class HubFactory {
  static Hub create() {
    final hub = Hub();
    final effect =
        MoveEffect.to(Vector2(0, screenSize.y - hub.size.y), EffectController(duration: 2, curve: Curves.easeOutCubic));
    hub.add(effect);
    return hub;
  }
}

class Hub extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  Hub()
      : super(
          size: Vector2(screenSize.x, screenSize.y / 5),
          position: Vector2(0, screenSize.y + screenSize.y / 5),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = Sprite(gameRef.images.fromCache(ImageAssets.controlPanel));
    await initBatteryLevel();
    await initPollutionLevel();
    initRudderJoystick();
    initRobotDeployButton();
    initReleaseTrashButton();
  }

  Future<void> initBatteryLevel() async {
    final batteryLevelComponent = await BatteryLevelRiveComponentFactory.create();
    batteryLevelComponent.size = Vector2(size.x / 4, size.y / 4);
    batteryLevelComponent.position = Vector2(300, 10);
    add(batteryLevelComponent);
  }

  Future<void> initPollutionLevel() async {
    final pollutionLevelComponent = await PollutionLevelRiveComponentFactory.create();
    pollutionLevelComponent.size = Vector2(size.x / 4, size.y / 4);
    pollutionLevelComponent.position = Vector2(300, size.y / 2);
    add(pollutionLevelComponent);
  }

  void initRudderJoystick() {
    final rudderJoystick = RudderJoystick();
    rudderJoystick.size = Vector2(size.x / 5, size.y);
    rudderJoystick.position = Vector2(60, 20);
    add(rudderJoystick);
  }

  void initRobotDeployButton() {
    final robotDeployButton = RobotDeployButton();
    robotDeployButton.position = Vector2(size.x - robotDeployButton.size.x - 200, 30);
    add(robotDeployButton);
  }

  void initReleaseTrashButton() {
    final releaseTrashButton = RobotReleaseTrashButton();
    releaseTrashButton.position = Vector2(size.x - releaseTrashButton.size.x - 60, 30);
    add(releaseTrashButton);
  }
}
