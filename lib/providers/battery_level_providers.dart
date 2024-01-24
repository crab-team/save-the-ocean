import 'package:flutter/material.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';

Map<GarbageType, double> garbageTypeToLevel = {
  GarbageType.plasticBag: 3.5,
  GarbageType.bottle: 2.5,
  GarbageType.tire: 6.0,
  GarbageType.paper: 2.0,
  GarbageType.banana: 0.5,
};

class BatteryLevelNotifier extends ChangeNotifier {
  double _level = 100.0;

  double get level => _level;

  set level(double newLevel) {
    _level = newLevel;
    notifyListeners();
  }
}
