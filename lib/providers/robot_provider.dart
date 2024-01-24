import 'package:flutter/material.dart';

class RobotNotifier extends ChangeNotifier {
  double _velocity = 0;

  double get velocity => _velocity;

  void moveLeft() {
    _velocity -= 3;
    notifyListeners();
  }

  void moveRight() {
    _velocity += 3;
    notifyListeners();
  }

  void stop() {
    _velocity = 0;
    notifyListeners();
  }
}
