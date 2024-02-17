import 'dart:math';

import 'package:flame/components.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_component.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';
import 'package:save_the_ocean/controllers/game/battery_level_controller.dart';
import 'package:save_the_ocean/screens/game/game.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class GarbageController {
  final SaveTheOceanGame game;
  final World world;

  GarbageController(this.world, this.game);

  void spawnGarbage() {
    List<Garbage> garbages = [
      Garbage.bottle(),
      Garbage.plastic(),
      Garbage.beer(),
      Garbage.tire(),
    ];

    Random random = Random.secure();
    Garbage garbage = garbages[random.nextInt(garbages.length)];

    if (spawnTool()) garbage = Garbage.tools();
    if (spawnBattery()) garbage = Garbage.battery();

    final garbageComponent = GarbageComponent(garbage: garbage);
    garbageComponent.priority = -1;
    world.add(garbageComponent);

    incrementPollutionLevel(garbage.type);
    decrementBatteryLevel();
  }

  bool spawnTool() {
    bool isTimeToSpawn = game.elapsedTime.ceil() % 11 == 0;
    return isTimeToSpawn;
  }

  bool spawnBattery() {
    bool worldContainsBattery = world.children.any((element) {
      if (element is GarbageComponent) {
        return element.garbage.type == GarbageType.battery;
      }
      return false;
    });

    bool isTimeToSpawn = game.elapsedTime.ceil() % 10 == 0;
    return isTimeToSpawn && !worldContainsBattery;
  }

  void incrementPollutionLevel(GarbageType garbageType) {
    if (garbageType == GarbageType.battery || garbageType == GarbageType.tools) return;
    pollutionLevelController.level += garbageTypeToLevel[garbageType]! * 0.4;
  }

  void decrementBatteryLevel() {
    if (batteryLevelController.level > 0) {
      batteryLevelController.level -= 3;
    }
  }
}
