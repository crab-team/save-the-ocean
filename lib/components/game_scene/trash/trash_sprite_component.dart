import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game_screen.dart';

class TrashRiveComponentFactory {
  static Future<TrashRiveComponent> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.riv), artboardName: ArtboardNames.trash);
    return TrashRiveComponent(artboard: artboard);
  }
}

class TrashRiveComponent extends RiveComponent {
  StateMachineController? controller;

  late SMITrigger? recycling;

  TrashRiveComponent({required super.artboard});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    recycling = controller?.findInput<bool>("recycling") as SMITrigger;
    listenBatteryLevel();
  }

  void listenBatteryLevel() {
    recyclingController.addListener(() {
      if (recyclingController.value) recycling?.fire();
    });
  }
}
