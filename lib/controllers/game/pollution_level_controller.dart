import 'package:flutter/material.dart';

class PollutionLevelController extends ChangeNotifier {
  double _level = 0.0;

  double get level => _level;

  set level(double newLevel) {
    _level = newLevel;
    notifyListeners();
  }

  void restart() {
    _level = 0.0;
    notifyListeners();
  }
}
