import 'dart:math';

import 'package:flame/components.dart';
import 'package:save_the_ocean/components/garbage/garbage_component.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';

class GarbageController {
  final World world;

  GarbageController(this.world);

  void spawnGarbage() {
    List<Garbage> garbages = [
      Garbage.banana(),
      Garbage.bottle(),
      Garbage.paper(),
      Garbage.plasticBag(),
      Garbage.tire(),
    ];

    Random random = Random.secure();
    Garbage garbage = garbages[random.nextInt(garbages.length)];
    final garbageComponent = GarbageComponent(garbage: garbage);
    garbageComponent.priority = -1;
    world.add(garbageComponent);
    incrementPollutionLevel(garbage.type);
    decrementBatteryLevel();
  }

  void incrementPollutionLevel(GarbageType garbageType) {
    pollutionLevelNotifier.level += garbageTypeToLevel[garbageType]! / 2;
  }

  void decrementBatteryLevel() {
    if (batteryLevelNotifier.level > 0) {
      batteryLevelNotifier.level -= 4;
    }
  }
}
