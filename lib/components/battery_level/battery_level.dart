import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/battery_level/battery_level_controller.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';

class BatteryLevelComponentFactory {
  static Future<BatteryLevelComponent> create(BatteryLevelController batteryLevelController) async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: 'battery_level');
    return BatteryLevelComponent(artboard: artboard, batteryLevelController: batteryLevelController);
  }
}

class BatteryLevelComponent extends RiveComponent {
  final BatteryLevelController batteryLevelController;

  StateMachineController? controller;

  double level = 0;
  late SMINumber? levelInput;

  BatteryLevelComponent({required super.artboard, required this.batteryLevelController});

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

    levelInput?.value = level;
  }

  void updateBatteryLevelByGarbageType(GarbageType type) {
    batteryLevelController.updateBatteryLevelByGarbageType(type);
  }
}
