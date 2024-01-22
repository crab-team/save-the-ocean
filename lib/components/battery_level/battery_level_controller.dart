import 'package:save_the_ocean/components/battery_level/battery_level.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';
import 'package:flame/timer.dart';

Map<GarbageType, double> garbageTypeToBatteryLevel = {
  GarbageType.plasticBag: 10.0,
  GarbageType.bottle: 20.0,
  GarbageType.tire: 30.0,
  GarbageType.paper: 40.0,
  GarbageType.banana: 50.0,
};

class BatteryLevelController {
  final BatteryLevelComponent batteryLevel;

  BatteryLevelController(this.batteryLevel);

  final countdown = Timer(2);

  void updateBatteryLevel(double level) {
    batteryLevel.levelInput?.value += level;
  }

  void updateBatteryLevelByGarbageType(GarbageType garbageType) {
    double levelToIncrease = garbageTypeToBatteryLevel[garbageType]!;
    print('Battery level increased by $levelToIncrease');
    updateBatteryLevel(levelToIncrease);
  }
}
