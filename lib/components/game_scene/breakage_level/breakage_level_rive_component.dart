import 'dart:async';

import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class BreakageLevelRiveComponentFactory {
  static Future<BreakageLevelRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: ArtboardNames.breakageLevel);
    return BreakageLevelRiveComponent(artboard: artboard);
  }
}

class BreakageLevelRiveComponent extends RiveComponent {
  StateMachineController? controller;
  late SMINumber? levelInput;

  BreakageLevelRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");

    artboard.addController(controller!);
    levelInput = controller?.findInput<double>("level") as SMINumber;
    listenBreakageLevel();
  }

  void listenBreakageLevel() {
    breakageLevelController.addListener(() {
      levelInput?.value = breakageLevelController.level;
    });
  }
}
