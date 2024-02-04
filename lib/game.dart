import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/painting.dart';
import 'package:save_the_ocean/components/game_scene/foreground_component.dart';
import 'package:save_the_ocean/components/game_scene/ground_component.dart';
import 'package:save_the_ocean/components/game_scene/lighting_component.dart';
import 'package:save_the_ocean/components/game_scene/timer_text_component.dart';
import 'package:save_the_ocean/components/game_scene/wall_component.dart';
import 'package:save_the_ocean/components/garbage/garbage_controller.dart';
import 'package:save_the_ocean/components/hub/hub.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/robot/robot_factory.dart';
import 'package:save_the_ocean/components/trash/trash.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';
import 'package:save_the_ocean/providers/game_providers.dart';
import 'package:save_the_ocean/providers/pollution_level_providers.dart';
import 'package:save_the_ocean/providers/robot_deploy_provider.dart';
import 'package:save_the_ocean/providers/robot_position_provider.dart';
import 'package:save_the_ocean/providers/robot_release_trash_providers.dart';

final screenSize = Vector2(1280, 720);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);
final batteryLevelNotifier = BatteryLevelNotifier();
final pollutionLevelNotifier = PollutionLevelNotifier();
final robotPositionNotifier = RobotPositionNotifier();
final robotDeployNotifier = RobotDeployNotifier();
final robotReleaseTrashNotifier = RobotReleaseTrashNotifier();
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

    final parallaxImages = [
      ParallaxImageData(ImageAssets.backgroundBehind1),
      ParallaxImageData(ImageAssets.backgroundBehind2),
      ParallaxImageData(ImageAssets.backgroundBehind3),
      ParallaxImageData(ImageAssets.backgroundMiddle1),
      ParallaxImageData(ImageAssets.backgroundMiddle2),
      ParallaxImageData(ImageAssets.backgroundMiddle3),
    ];

    final parallax = await loadParallaxComponent(
      parallaxImages,
      velocityMultiplierDelta: Vector2(1.8, 1.0),
      filterQuality: FilterQuality.none,
    );
    camera.backdrop.add(parallax);

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
    await loadSprite(ImageAssets.backgroundBehind1);
    await loadSprite(ImageAssets.backgroundBehind2);
    await loadSprite(ImageAssets.backgroundBehind3);
    await loadSprite(ImageAssets.foreground1);
    await loadSprite(ImageAssets.foreground2);
    await loadSprite(ImageAssets.backgroundMiddle1);
    await loadSprite(ImageAssets.backgroundMiddle2);
    await loadSprite(ImageAssets.backgroundMiddle3);
    await loadSprite(ImageAssets.foreground1);
    await loadSprite(ImageAssets.foreground2);
    await loadSprite(ImageAssets.level);
    await loadSprite(ImageAssets.bottle);
    await loadSprite(ImageAssets.controlPanel);
  }

  void addCameraElements() {
    camera.viewport.addAll([
      ForegroundComponent(path: ImageAssets.foreground2),
      ForegroundComponent(path: ImageAssets.foreground1),
      HubFactory.create(),
      LightingPositionComponent(),
      TimerTextComponent(),
      FpsTextComponent(),
    ]);
  }

  void addWorldElements() async {
    world.addAll([
      robot,
      Trash(),
      GroundBodyComponentFactory.create(),
      WallComponentFactory.create(false),
      WallComponentFactory.create(true),
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
