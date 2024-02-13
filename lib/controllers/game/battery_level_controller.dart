import 'package:flutter/material.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';

Map<GarbageType, double> garbageTypeToLevel = {
  GarbageType.beer: 3.5,
  GarbageType.bottle: 2.5,
  GarbageType.tire: 6.0,
  GarbageType.plastic: 2.0,
  GarbageType.battery: 0.5,
};

class BatteryLevelController extends ChangeNotifier {
  double _level = 100.0;

  double get level => _level;

  set level(double newLevel) {
    _level = newLevel;
    notifyListeners();
  }

  void restart() {
    _level = 100.0;
    notifyListeners();
  }
}
