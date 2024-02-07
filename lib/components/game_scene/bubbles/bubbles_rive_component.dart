import 'dart:async';

import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';

class BubblesRiveComponentFactory {
  static Future<BubblesRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: 'bubbles');
    return BubblesRiveComponent(artboard: artboard);
  }
}

class BubblesRiveComponent extends RiveComponent {
  StateMachineController? controller;

  BubblesRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
  }
}
