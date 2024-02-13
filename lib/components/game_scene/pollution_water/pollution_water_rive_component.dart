import 'dart:async';

import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class PollutionWaterRiveComponentFactory {
  static Future<PollutionWaterRiveComponent> create() async {
    final artboard =
        await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: ArtboardNames.pollutionWater);
    return PollutionWaterRiveComponent(artboard: artboard);
  }
}

class PollutionWaterRiveComponent extends RiveComponent {
  StateMachineController? controller;

  late SMINumber? levelInput;

  PollutionWaterRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    levelInput = controller?.findInput<double>("pollution_level") as SMINumber;
    listenBatteryLevel();
  }

  void listenBatteryLevel() {
    pollutionLevelController.addListener(() {
      levelInput?.value = pollutionLevelController.level;
    });
  }
}
