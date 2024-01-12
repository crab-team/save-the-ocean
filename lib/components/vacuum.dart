import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

class VacuumFactory {
  static Future<Vacuum> create() async {
    final artboard = await loadArtboard(RiveFile.asset('assets/animations/save_the_ocean.riv'), artboardName: 'recycler');
    return Vacuum(artboard: artboard);
  }
}

class Vacuum extends RiveComponent with HasGameRef<SaveTheOceanGame> {
  late StateMachineController? controller;

  SMIInput<bool>? _isVacuuming;
  SMIInput<bool>? _isRecycling;

  Vacuum({required super.artboard}) : super(size: Vector2.all(200));

  @override
  Future<void> onLoad() async {
    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    _isVacuuming = controller?.findInput<bool>("vacuuming");
    _isRecycling = controller?.findInput<bool>("recycling");
  }

  @override
  void update(double dt) {
    super.update(dt);

    bool joystickLeft = joystick.direction == JoystickDirection.left;
    bool joystickRight = joystick.direction == JoystickDirection.right;

    if (joystickLeft) {
      position.x -= 8 * joystick.intensity;
    }

    if (joystickRight) {
      position.x += 8 * joystick.intensity;
    }
  }

  void aspire() {
    _isVacuuming?.value = true;
  }
}
