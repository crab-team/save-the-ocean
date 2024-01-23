import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/battery_level/battery_level_controller.dart';
import 'package:save_the_ocean/components/garbage/garbage_component.dart';
import 'package:save_the_ocean/game.dart';

class Trash extends BodyComponent with ContactCallbacks {
  final BatteryLevelController batteryLevelController;

  Trash({required this.batteryLevelController});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x - 1.5, worldSize.y - 3),
      type: BodyType.static,
    );

    final shape = ChainShape()
      ..createChain([
        Vector2(-1, 2),
        Vector2(-1, 3),
        Vector2(0.8, 3),
        Vector2(0.8, 2),
      ]);
    final fixtureDef = FixtureDef(shape);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is GarbageComponent) {
      print('${other.garbage.type.name.toUpperCase()} was removed from the world');
      batteryLevelController.updateBatteryLevelByGarbageType(other.garbage.type);
      other.removeFromParent();
    }
  }
}
