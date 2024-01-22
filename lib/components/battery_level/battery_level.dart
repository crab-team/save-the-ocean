import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/battery_level/battery_level_controller.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';

class BatteryLevelComponentFactory {
  static Future<BatteryLevelComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: 'battery_level');
    return BatteryLevelComponent(artboard: artboard);
  }
}

class BatteryLevelComponent extends RiveComponent {
  late BatteryLevelController _batteryLevelController;
  StateMachineController? controller;

  double level = 0;
  late SMINumber? levelInput;
  final countdown = Timer(2);

  BatteryLevelComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
    _batteryLevelController = BatteryLevelController(this);
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    levelInput = controller?.findInput<double>("level") as SMINumber;
    anchor = Anchor.topLeft;
    position = Vector2(3, 3);
    size = Vector2(artboard.width / 2, artboard.height / 2);

    levelInput?.value = level;
  }

  @override
  void update(double dt) {
    super.update(dt);
    countdown.update(dt);
    if (countdown.finished) {
      // _batteryLevelController.updateBatteryLevel(-1);
    }
  }

  void updateBatteryLevelByGarbageType(GarbageType type) {
    _batteryLevelController.updateBatteryLevelByGarbageType(type);
  }
}
