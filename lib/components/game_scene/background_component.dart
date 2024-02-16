import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class FishRiveComponentFactory {
  static Future<FishRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: ArtboardNames.fish);
    return FishRiveComponent(artboard: artboard);
  }
}

class FishRiveComponent extends RiveComponent {
  StateMachineController? controller;

  FishRiveComponent({required super.artboard});

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
    final fishAnimationRiveComponent = await FishRiveComponentFactory.create();
    fishAnimationRiveComponent.position = Vector2(0, screenSize.y / 3);
    final backgroundFarComponent = BackgroundFarComponent();
    final backgroundFrontComponent = BackgroundFrontComponent();

    add(backgroundFarComponent);
    add(fishAnimationRiveComponent);
    add(backgroundFrontComponent);
  }
}

class BackgroundFarComponent extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(ImageAssets.backgroundFar);
  }
}

class BackgroundFrontComponent extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(ImageAssets.backgroundFront);
  }
}
