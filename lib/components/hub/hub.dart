import 'package:flame/components.dart';
import 'package:save_the_ocean/components/hub/battery_level_rive_component.dart';
import 'package:save_the_ocean/components/hub/pollution_level_rive_component.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class Hub extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  Hub()
      : super(
          size: Vector2(screenSize.x, screenSize.y / 4),
          position: Vector2(0, screenSize.y - screenSize.y / 5),
        );

  late BatteryLevelRiveComponent _batteryLevelComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = Sprite(gameRef.images.fromCache(ImageAssets.controlPanel));
    await initBatteryLevel();
    await initPollutionLevel();
  }

  Future<void> initBatteryLevel() async {
    _batteryLevelComponent = await BatteryLevelRiveComponentFactory.create();
    _batteryLevelComponent.size = Vector2(size.x / 4, size.y / 4);
    _batteryLevelComponent.position = Vector2(size.x / 11, 10);
    add(_batteryLevelComponent);
  }

  Future<void> initPollutionLevel() async {
    final pollutionLevelComponent = await PollutionLevelRiveComponentFactory.create();
    pollutionLevelComponent.size = Vector2(size.x / 4, size.y / 4);
    pollutionLevelComponent.position = Vector2(size.x / 11, size.y / 2);
    add(pollutionLevelComponent);
  }
}
