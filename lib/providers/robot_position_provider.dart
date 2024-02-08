import 'package:flutter/material.dart';

class RobotPositionNotifier extends ChangeNotifier {
  double _velocity = 0;

  double get velocity => _velocity;

  void moveLeft() {
    _velocity -= 7;
    notifyListeners();
  }

  void moveRight() {
    _velocity += 7;
    notifyListeners();
  }

  void stop() {
    _velocity = 0;
    notifyListeners();
  }
}
