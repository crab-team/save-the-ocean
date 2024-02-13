import 'dart:async';

import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class BatteryLevelRiveComponentFactory {
  static Future<BatteryLevelRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: ArtboardNames.batteryLevel);
    return BatteryLevelRiveComponent(artboard: artboard);
  }
}

class BatteryLevelRiveComponent extends RiveComponent {
  StateMachineController? controller;
  StateMachineController? thunderController;

  late SMINumber? levelInput;
  late SMITrigger? recycling;

  BatteryLevelRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    thunderController = StateMachineController.fromArtboard(artboard, "state_machine_blink");
    if (controller == null || thunderController == null) return;

    artboard.addController(controller!);
    levelInput = controller?.findInput<double>("level") as SMINumber;
    recycling = thunderController?.findInput<bool>("recycling") as SMITrigger;
    listenRecycling();
    listenBatteryLevel();
  }

  void listenRecycling() {
    recyclingController.addListener(() {
      if (recyclingController.value) recycling?.fire();
    });
  }

  void listenBatteryLevel() {
    batteryLevelController.addListener(() {
      levelInput?.value = batteryLevelController.level;
    });
  }
}
