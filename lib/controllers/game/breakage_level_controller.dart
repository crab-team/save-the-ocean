import 'package:flutter/material.dart';

class BreakageLevelController extends ChangeNotifier {
  double _level = 100.0;
  bool _isBroken = false;

  double get level => _level;
  bool get isBroken => _isBroken;

  set level(double newLevel) {
    _level = newLevel;
    notifyListeners();
  }

  set isBroken(bool value) {
    _isBroken = value;
    notifyListeners();
  }

  void incrementLevel() {
    _level += 10;
    notifyListeners();
  }

  void decrementLevel() {
    _level -= 50;
    if (_level <= 0) {
      _isBroken = true;
    }
    notifyListeners();
  }

  void restart() {
    _level = 100.0;
    _isBroken = false;
    notifyListeners();
  }
}
