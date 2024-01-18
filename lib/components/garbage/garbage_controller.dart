import 'dart:math';

import 'package:flame/components.dart';
import 'package:save_the_ocean/components/garbage/garbage.dart';

class GarbageController {
  final World world;

  GarbageController(this.world);

  void createGarbagesRamdomly() {
    for (var i = 0; i < 25; i++) {
      Future.delayed(Duration(seconds: i + 1), () {
        Random random = Random.secure();
        double randomNumber = random.nextDouble() * 3;

        final garbage = Garbage(
          initialLinearVelocityX: randomNumber + 2,
          initialAngularVelocity: randomNumber,
          fromLeft: true,
        );
        world.add(garbage);
      });
    }
  }
}
