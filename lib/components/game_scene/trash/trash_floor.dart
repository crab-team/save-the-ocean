import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_component.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/domain/entities/garbage.dart';
import 'package:save_the_ocean/screens/game/game.dart';
import 'package:save_the_ocean/controllers/game/battery_level_controller.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class TrashFloor extends BodyComponent with ContactCallbacks {
  final bool isSoundOn;

  TrashFloor({required this.isSoundOn});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x - 5.5, worldSize.y),
      type: BodyType.static,
    );

    final shape = ChainShape()
      ..createChain([
        Vector2(0.6, -2),
        Vector2(2.8, -2),
      ]);
    final fixtureDef = FixtureDef(shape);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is GarbageComponent) {
      if (other.garbage.type == GarbageType.battery) {
        if (isSoundOn) FlameAudio.play(AudioAssets.batteryReward, volume: 0.2);
        incrementBatteryLevel(100);
        other.removeFromParent();
        return;
      }

      if (other.garbage.type == GarbageType.tools) {
        if (isSoundOn) FlameAudio.play(AudioAssets.reward, volume: 0.2);
        breakageLevelController.incrementLevel();
        other.removeFromParent();
        return;
      }

      double garbageToLevel = garbageTypeToLevel[other.garbage.type]!;
      recycling();
      incrementBatteryLevel(garbageToLevel);
      decrementPollutionLevel(garbageToLevel);
      other.removeFromParent();
    }
  }

  void recycling() {
    recyclingController.value = true;
    Future.microtask(() => recyclingController.value = false);
  }

  void incrementBatteryLevel(double level) {
    batteryLevelController.level += level;
  }

  void decrementPollutionLevel(double level) {
    pollutionLevelController.level -= level;
  }
}
