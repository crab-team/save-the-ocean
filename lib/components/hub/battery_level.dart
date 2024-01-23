import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/main.dart';

class BatteryLevelComponentFactory {
  static Future<BatteryLevelComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: 'battery_level');
    return BatteryLevelComponent(artboard: artboard);
  }
}

class BatteryLevelComponent extends RiveComponent {
  StateMachineController? controller;

  late SMINumber? levelInput;

  BatteryLevelComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    levelInput = controller?.findInput<double>("level") as SMINumber;
    anchor = Anchor.topLeft;
    position = Vector2(3, 3);
    size = Vector2(artboard.width / 2, artboard.height / 2);
    listenBatteryLevel();
  }

  void listenBatteryLevel() {
    batteryLevelNotifier.addListener(() {
      levelInput?.value = batteryLevelNotifier.level;
    });
  }
}
