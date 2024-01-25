import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/game_scene/background.dart';
import 'package:save_the_ocean/components/game_scene/ground_component.dart';
import 'package:save_the_ocean/components/game_scene/timer_text_component.dart';
import 'package:save_the_ocean/components/game_scene/wall_component.dart';
import 'package:save_the_ocean/components/garbage/garbage_controller.dart';
import 'package:save_the_ocean/components/hub/hub.dart';
import 'package:save_the_ocean/components/hub/robot_release_joystick.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/robot/robot_factory.dart';
import 'package:save_the_ocean/components/trash/trash.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';
import 'package:save_the_ocean/providers/game_providers.dart';
import 'package:save_the_ocean/providers/pollution_level_providers.dart';
import 'package:save_the_ocean/providers/robot_deploy_provider.dart';
import 'package:save_the_ocean/providers/robot_position_provider.dart';

final screenSize = Vector2(1280, 720);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);
final batteryLevelNotifier = BatteryLevelNotifier();
final pollutionLevelNotifier = PollutionLevelNotifier();
final robotPositionNotifier = RobotPositionNotifier();
final robotDeployNotifier = RobotDeployNotifier();
final gameNotifier = GameNotifier();

class SaveTheOceanGame extends Forge2DGame {
  late Robot robot;
  late GarbageController _garbageController;
  late TimerComponent timer;

  SaveTheOceanGame()
      : super(
          zoom: cameraZoom,
          cameraComponent: CameraComponent.withFixedResolution(
            width: screenSize.x,
            height: screenSize.y,
          ),
          gravity: Vector2(0, 15.0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await loadAssets();
    _garbageController = GarbageController(world);
    robot = await RobotFactory.create();
    camera.moveTo(worldSize / 2);

    addCameraElements();
    addWorldElements();
  }

  Future<void> loadAssets() async {
    await loadSprite(ImageAssets.background);
    await loadSprite(ImageAssets.controlPanel);
  }

  void addCameraElements() {
    camera.backdrop.add(Background(size: screenSize));
    camera.viewport.addAll([
      HubFactory.create(),
      TimerTextComponent(),
      FpsTextComponent(),
      robotReleaseJoystick,
    ]);
  }

  void addWorldElements() async {
    world.addAll([
      GroundBodyComponentFactory.create(),
      WallComponentFactory.create(true),
      WallComponentFactory.create(false),
      robot,
      Trash(),
      TimerComponent(
          period: 1,
          autoStart: true,
          repeat: true,
          onTick: () {
            // _garbageController.createGarbagesRamdomly();
            if (batteryLevelNotifier.level > 0) batteryLevelNotifier.level -= 2;
          })
    ]);
  }
}
