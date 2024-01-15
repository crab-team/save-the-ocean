import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/utils/logger.dart';

class RiveRobotHeadFactory {
  static Future<RiveRobotHead> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.robot_body), artboardName: 'recycler');
    return RiveRobotHead(artboard: artboard);
  }
}

class RiveRobotHead extends RiveComponent with HasGameRef<SaveTheOceanGame> {
  StateMachineController? controller;
  SMIInput<bool>? _vacuumingInput;
  SMIInput<bool>? _recyclingInput;

  final int vacuumTime = 1500;
  final int recycleTime = 1500;

  RiveRobotHead({required super.artboard}) : super(size: Vector2.all(2));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;

    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    _vacuumingInput = controller?.findInput<bool>("vacuuming");
    _recyclingInput = controller?.findInput<bool>("recycling");

    anchor = Anchor.center;
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
    await Future.delayed(Duration(milliseconds: vacuumTime), () => _recycle());
    await Future.delayed(Duration(milliseconds: recycleTime), () => _idle());
  }

  void _recycle() {
    Logger.log('Vacuum -> Recycle');
    _vacuumingInput?.value = false;
    _recyclingInput?.value = true;
  }

  void _idle() {
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
