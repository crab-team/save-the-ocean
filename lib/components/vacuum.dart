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
  SMIInput<bool>? _vacuumingInput;
  SMIInput<bool>? _recyclingInput;

  final int vacuumTime = 1500;
  final int recycleTime = 1500;

  Vacuum({required super.artboard}) : super(size: Vector2.all(200));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    _vacuumingInput = controller?.findInput<bool>("vacuuming");
    _recyclingInput = controller?.findInput<bool>("recycling");
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

    if (_isVacuuming()) {
      Logger.log('Vacuum -> Is vacuuming. Wait until it finishes');
      return;
    }

     if (_isRecycling()) {
      Logger.log('Vacuum -> Is recycling. Wait until it finishes');
      return;
    }

    _vacuumingInput?.value = true;
    await Future.delayed(Duration(milliseconds: vacuumTime), () => recycle());
    await Future.delayed(Duration(milliseconds: recycleTime), () => idle());
  }

  void recycle() {
    Logger.log('Vacuum -> Recycle');
    _vacuumingInput?.value = false;
    _recyclingInput?.value = true;
  }

  void idle() {
    Logger.log('Vacuum -> Idle');
    _vacuumingInput?.value = false;
    _recyclingInput?.value = false;
  }

  bool _isVacuuming() {
    return _vacuumingInput?.value ?? false;
  }

  bool _isRecycling() {
    return _recyclingInput?.value ?? false;
  }
}
