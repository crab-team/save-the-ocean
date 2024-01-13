import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

class RiveVacuumFactory {
  static Future<RiveVacuum> create() async {
    final artboard =
        await loadArtboard(RiveFile.asset(AnimationAssets.recycler), artboardName: 'recycler');
    return RiveVacuum(artboard: artboard);
  }
}

class Vacuum extends BodyComponent {
  final RiveVacuum vacuum;

  Vacuum({required this.vacuum});

  // @override
  // Future<void> onLoad() async {
  //   await super.onLoad();
  //   add(vacuum);
  // }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(worldSize.x / 2, 0 + 0.5),
      type: BodyType.static,
    );

    final shape = PolygonShape()..setAsBoxXY(0.5, 0.5);

    final fixtureDef = FixtureDef(
      shape,
      userData: this,
      restitution: 0.75,
      friction: 0.1,
      density: 0.1,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);

    bool joystickLeft = joystick.direction == JoystickDirection.left;
    bool joystickRight = joystick.direction == JoystickDirection.right;

    if (joystickLeft) {
      position.x -= 0.2 * joystick.intensity;
    }

    if (joystickRight) {
      position.x += 0.2 * joystick.intensity;
    }
  }
}

class RiveVacuum extends RiveComponent with HasGameRef<SaveTheOceanGame> {
  StateMachineController? controller;
  SMIInput<bool>? _isVacuuming;
  SMIInput<bool>? _isRecycling;

  RiveVacuum({required super.artboard}) : super(size: Vector2.all(200));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    _isVacuuming = controller?.findInput<bool>("vacuuming");
    _isRecycling = controller?.findInput<bool>("recycling");
  }

  void aspire() async {
    debugPrint('${DateTime.now()} > Rive Vacuum -> Aspire');
    _isVacuuming?.value = true;
    await Future.delayed(const Duration(seconds: 1), () => recycle());
    await Future.delayed(const Duration(seconds: 1), () => idle());
  }

  void recycle() {
    debugPrint('${DateTime.now()} > Rive Vacuum -> Recycle');
    _isVacuuming?.value = false;
    _isRecycling?.value = true;
  }

  void idle() {
    debugPrint('${DateTime.now()} > Rive Vacuum -> Idle');
    _isVacuuming?.value = false;
    _isRecycling?.value = false;
  }
}
