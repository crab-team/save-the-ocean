import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/inputs/joystick.dart';
import 'package:save_the_ocean/utils/logger.dart';

class VacuumFactory {
  static Future<Vacuum> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.recycler), artboardName: 'recycler');
    return Vacuum(artboard: artboard);
  }
}

// TODO: Tendria que ser un BodyComponent que contenga este RiveComponent para poder usarlo en el 'World' y manejar colisiones
class Vacuum extends RiveComponent with HasGameRef<SaveTheOceanGame> {
  StateMachineController? controller;
  SMIInput<bool>? _isVacuuming;
  SMIInput<bool>? _isRecycling;

  final int vacuumTime = 1500;
  final int recycleTime = 1500;

  Vacuum({required super.artboard}) : super(size: Vector2.all(200));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

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

  void aspire() async {
    Logger.log('Vacuum -> Aspire');
    _isVacuuming?.value = true;
    await Future.delayed(Duration(milliseconds: vacuumTime), () => recycle());
    await Future.delayed(Duration(milliseconds: recycleTime), () => idle());
  }

  void recycle() {
    Logger.log('Vacuum -> Recycle');
    _isVacuuming?.value = false;
    _isRecycling?.value = true;
  }

  void idle() {
    Logger.log('Vacuum -> Idle');
    _isVacuuming?.value = false;
    _isRecycling?.value = false;
  }
}
