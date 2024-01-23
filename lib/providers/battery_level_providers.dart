import 'package:flutter/material.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';

Map<GarbageType, double> garbageTypeToBatteryLevel = {
  GarbageType.plasticBag: 1.0,
  GarbageType.bottle: 2.0,
  GarbageType.tire: 3.0,
  GarbageType.paper: 4.0,
  GarbageType.banana: 5.0,
};

class BatteryLevelNotifier extends ChangeNotifier {
  double _level = 0.0;

  double get level => _level;

  set level(double newLevel) {
    _level = newLevel;
    notifyListeners();
  }
}
