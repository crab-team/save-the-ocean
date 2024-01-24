import 'dart:async';

import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class PollutionLevelRiveComponentFactory {
  static Future<PollutionLevelRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: 'pollution_level');
    return PollutionLevelRiveComponent(artboard: artboard);
  }
}

class PollutionLevelRiveComponent extends RiveComponent {
  StateMachineController? controller;

  late SMINumber? levelInput;

  PollutionLevelRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    levelInput = controller?.findInput<double>("level") as SMINumber;
    listenBatteryLevel();
  }

  void listenBatteryLevel() {
    batteryLevelNotifier.addListener(() {
      levelInput?.value = pollutionLevelNotifier.level;
    });
  }
}
