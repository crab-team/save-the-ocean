import 'dart:math';

import 'package:flame/components.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_component.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';
import 'package:save_the_ocean/controllers/game/battery_level_controller.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class GarbageController {
  final World world;

  GarbageController(this.world);

  void spawnGarbage() {
    List<Garbage> garbages = [
      Garbage.battery(),
      Garbage.bottle(),
      Garbage.plastic(),
      Garbage.beer(),
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
    pollutionLevelController.level += garbageTypeToLevel[garbageType]!;
  }

  void decrementBatteryLevel() {
    if (batteryLevelController.level > 0) {
      batteryLevelController.level -= 4;
    }
  }
}
