import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';

class LightingRiveComponentFactory {
  static Future<LightingRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: ArtboardNames.lighting);
    return LightingRiveComponent(artboard: artboard);
  }
}

class LightingRiveComponent extends RiveComponent {
  StateMachineController? controller;

  LightingRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;
    artboard.addController(controller!);
  }
}

class LightingPositionComponent extends PositionComponent {
  @override
  onLoad() async {
    final lightingRiveComponent = await LightingRiveComponentFactory.create();
    lightingRiveComponent.priority = 2;
    add(lightingRiveComponent);
  }
}
