import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';
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
  late Timer timer;

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
    initTimer();
    gameListeners();

    _garbageController = GarbageController(world);
    robot = await RobotFactory.create();
    camera.moveTo(worldSize / 2);

    addCameraElements();
    addWorldElements();
  }

  initTimer() {
    timer = Timer(
      1,
      onTick: () {
        print('spawn garbage');
        _garbageController.spawnGarbage();
      },
      repeat: true,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
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
    ]);
  }

  void gameListeners() {
    batteryLevelNotifier.addListener(() {
      if (batteryLevelNotifier.level <= 0) {
        gameNotifier.gameOver();
      }
    });

    pollutionLevelNotifier.addListener(() {
      if (pollutionLevelNotifier.level >= 100) {
        gameNotifier.gameOver();
      }
    });

    gameNotifier.addListener(() {
      if (gameNotifier.isGameOver) {
        timer.stop();
      }
    });
  }
}
