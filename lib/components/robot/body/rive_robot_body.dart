import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class RiveRobotBodyFactory {
  static Future<RiveRobotBody> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.robot_body), artboardName: 'recycler_vacuum');
    return RiveRobotBody(artboard: artboard);
  }
}

class RiveRobotBody extends RiveComponent with HasGameRef<SaveTheOceanGame> {
  StateMachineController? controller;
  SMIInput<bool>? _vacuumingInput;

  final int vacuumTime = 1500;
  final int recycleTime = 1500;

  RiveRobotBody({required super.artboard}) : super(size: Vector2.all(2));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    debugMode = kDebugMode;

    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    _vacuumingInput = controller?.findInput<bool>("vacumming");

    anchor = Anchor.center;
  }

  void aspire() {
    _vacuumingInput?.value = true;
  }
}