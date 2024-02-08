import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_component.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';

class TrashFloor extends BodyComponent with ContactCallbacks {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x - 5.5, worldSize.y),
      type: BodyType.static,
    );

    final shape = ChainShape()
      ..createChain([
        Vector2(0.4, 0),
        Vector2(3, 0),
      ]);
    final fixtureDef = FixtureDef(shape);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is GarbageComponent) {
      double garbageToLevel = garbageTypeToLevel[other.garbage.type]!;
      incrementBatteryLevel(garbageToLevel);
      decrementPollutionLevel(garbageToLevel);
      other.removeFromParent();
    }
  }

  void incrementBatteryLevel(double level) {
    batteryLevelNotifier.level += level;
  }

  void decrementPollutionLevel(double level) {
    pollutionLevelNotifier.level -= level;
  }
}
