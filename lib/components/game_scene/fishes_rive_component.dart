import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';

class FishesRiveComponentFactory {
  static Future<FishesRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: 'fishes');
    return FishesRiveComponent(artboard: artboard);
  }
}

class FishesRiveComponent extends RiveComponent {
  StateMachineController? controller;

  FishesRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;
    artboard.addController(controller!);
  }
}

class FishesPositionComponent extends PositionComponent {
  @override
  onLoad() async {
    final lightingRiveComponent = await FishesRiveComponentFactory.create();
    lightingRiveComponent.priority = 2;
    add(lightingRiveComponent);
  }
}
