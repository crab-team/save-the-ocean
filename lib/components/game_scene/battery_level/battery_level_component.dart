import 'package:flame/components.dart';
import 'package:save_the_ocean/components/game_scene/battery_level/battery_level_rive_component.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class BatteryLevelComponent extends PositionComponent {
  @override
  onLoad() async {
    await initBatteryLevel();
  }

  Future<void> initBatteryLevel() async {
    final batteryLevelComponent = await BatteryLevelRiveComponentFactory.create();
    batteryLevelComponent.size = Vector2(600, 100);
    batteryLevelComponent.position = Vector2(screenSize.x - batteryLevelComponent.size.x - 200, 140);
    add(batteryLevelComponent);
  }
}
