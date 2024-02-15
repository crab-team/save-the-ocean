import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';

class BackgroundRiveComponentFactory {
  static Future<BackgroundRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: ArtboardNames.background);
    return BackgroundRiveComponent(artboard: artboard);
  }
}

class BackgroundRiveComponent extends RiveComponent {
  StateMachineController? controller;

  BackgroundRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;
    artboard.addController(controller!);
  }
}

class BackgroundPositionComponent extends PositionComponent {
  @override
  onLoad() async {
    final riveComponent = await BackgroundRiveComponentFactory.create();
    add(riveComponent);
  }
}
