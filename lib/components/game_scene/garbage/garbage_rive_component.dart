import 'dart:async';

import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';

class GarbageRiveComponentFactory {
  final String artboardName;

  GarbageRiveComponentFactory({required this.artboardName});

  Future<GarbageRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: artboardName);
    return GarbageRiveComponent(artboard: artboard);
  }
}

class GarbageRiveComponent extends RiveComponent {
  StateMachineController? controller;

  GarbageRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
  }
}
