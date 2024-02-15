import 'package:flutter/material.dart';

class RobotPositionController extends ChangeNotifier {
  double _velocity = 0;
  bool _isFreezed = false;

  bool get isFreezed => _isFreezed;
  double get velocity => _velocity;

  set isFreezed(bool value) {
    _isFreezed = value;
    notifyListeners();
  }

  void moveLeft() {
    if (_isFreezed) return;
    _velocity -= 7;
    notifyListeners();
  }

  void moveRight() {
    if (_isFreezed) return;
    _velocity += 7;
    notifyListeners();
  }

  void stop() {
    _velocity = 0;
    notifyListeners();
  }
}
