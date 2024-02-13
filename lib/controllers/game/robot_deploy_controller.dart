import 'package:flutter/material.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class RobotDeployController extends ChangeNotifier {
  bool _deploy = false;

  bool get deploy => _deploy;

  void stopDeploy() {
    _deploy = false;
    notifyListeners();
  }

  void deployRobot() {
    if (deploy == true) return;
    robotPositionController.stop();
    _deploy = true;
    notifyListeners();
  }

  void refoldRobot() {
    if (deploy == false) return;
    robotPositionController.stop();
    _deploy = false;
    notifyListeners();
  }
}
