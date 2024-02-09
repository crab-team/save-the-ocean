import 'package:flutter/material.dart';
import 'package:save_the_ocean/screens/game_screen.dart';

class RobotDeployNotifier extends ChangeNotifier {
  bool _deploy = false;

  bool get deploy => _deploy;

  void stopDeploy() {
    _deploy = false;
    notifyListeners();
  }

  void deployRobot() {
    if (deploy == true) return;
    robotPositionNotifier.stop();
    _deploy = true;
    notifyListeners();
  }

  void refoldRobot() {
    if (deploy == false) return;
    robotPositionNotifier.stop();
    _deploy = false;
    notifyListeners();
  }
}
