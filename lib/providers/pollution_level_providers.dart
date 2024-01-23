import 'package:flutter/material.dart';

class PollutionLevelNotifier extends ChangeNotifier {
  double _level = 0.0;

  double get level => _level;

  set level(double newLevel) {
    _level = newLevel;
    notifyListeners();
  }
}
