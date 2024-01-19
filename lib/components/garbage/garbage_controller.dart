import 'dart:math';

import 'package:flame/components.dart';
import 'package:save_the_ocean/components/garbage/garbage_component.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';

class GarbageController {
  final World world;

  GarbageController(this.world);

  void createGarbagesRamdomly() {
    List<Garbage> garbages = [
      Garbage.banana(),
      Garbage.bottle(),
      Garbage.paper(),
      Garbage.plasticBag(),
      Garbage.tire(),
    ];

    for (var i = 0; i < 25; i++) {
      Future.delayed(Duration(seconds: i + 1), () {
        Random random = Random.secure();
        final garbage = GarbageComponent(garbage: garbages[random.nextInt(garbages.length)]);
        world.add(garbage);
      });
    }
  }
}
