import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/utils/logger.dart';

class RiveRobotFactory {
  static Future<RiveRobot> create() async {
    final artboard = await loadArtboard(RiveFile.asset(AnimationAssets.robot), artboardName: 'robot');
    return RiveRobot(artboard: artboard);
  }
}

class RiveRobot extends RiveComponent with HasGameRef<SaveTheOceanGame> {
  StateMachineController? controller;
  SMIInput<bool>? _deployingInput;
  SMIInput<bool>? _vacuumingInput;
  SMIInput<bool>? _refoldingInput;
  SMIInput<bool>? _recyclingInput;

  final int deployTime = 1000;
  final int vacuumTime = 1000;
  final int refoldTime = 500;
  final int recycleTime = 500;

  RiveRobot({required super.artboard}) : super(size: Vector2.all(3.5));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;

    controller = StateMachineController.fromArtboard(artboard, "state_machine");
    if (controller == null) return;

    artboard.addController(controller!);
    _deployingInput = controller?.findInput<bool>("deploying");
    _vacuumingInput = controller?.findInput<bool>("vacuuming");
    _refoldingInput = controller?.findInput<bool>("refolding");
    _recyclingInput = controller?.findInput<bool>("recycling");

    anchor = Anchor.center;
  }

  void deploy() async {
    Logger.log('Rive Robot -> Deploy');

    if (_isDeploying()) {
      Logger.log('Rive Robot -> Is deploying. Wait until it finishes');
      return;
    }

    if (_isVacuuming()) {
      Logger.log('Rive Robot -> Is vacuuming. Wait until it finishes');
      return;
    }

    if (_isRefolding()) {
      Logger.log('Rive Robot -> Is refolding. Wait until it finishes');
      return;
    }

    if (_isRecycling()) {
      Logger.log('Rive Robot -> Is recycling. Wait until it finishes');
      return;
    }

    _deployingInput?.value = true;
    _vacuumingInput?.value = false;
    _refoldingInput?.value = false;
    _recyclingInput?.value = false;

    await Future.delayed(Duration(milliseconds: deployTime), () => _vacuum());
    await Future.delayed(Duration(milliseconds: vacuumTime), () => _refold());
    await Future.delayed(Duration(milliseconds: refoldTime), () => _recycle());
    await Future.delayed(Duration(milliseconds: recycleTime), () => _idle());
  }

  void _vacuum() {
    Logger.log('Rive Robot -> Vacuum');
    _deployingInput?.value = false;
    _vacuumingInput?.value = true;
    _refoldingInput?.value = false;
    _recyclingInput?.value = false;
  }

  void _refold() {
    Logger.log('Rive Robot -> Refold');
    _deployingInput?.value = false;
    _vacuumingInput?.value = false;
    _refoldingInput?.value = true;
    _recyclingInput?.value = false;
  }

  void _recycle() {
    Logger.log('Rive Robot -> Recycle');
    _deployingInput?.value = false;
    _vacuumingInput?.value = false;
    _refoldingInput?.value = false;
    _recyclingInput?.value = true;
  }

  void _idle() {
    Logger.log('Rive Robot -> Idle');
    _deployingInput?.value = false;
    _vacuumingInput?.value = false;
    _refoldingInput?.value = false;
    _recyclingInput?.value = false;
  }

  bool _isDeploying() {
    return _deployingInput?.value ?? false;
  }

  bool _isVacuuming() {
    return _vacuumingInput?.value ?? false;
  }

  bool _isRefolding() {
    return _refoldingInput?.value ?? false;
  }

  bool _isRecycling() {
    return _recyclingInput?.value ?? false;
  }
}
