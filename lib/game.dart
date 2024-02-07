import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/painting.dart';
import 'package:save_the_ocean/components/game_scene/fishes_rive_component.dart';
import 'package:save_the_ocean/components/game_scene/foreground_component.dart';
import 'package:save_the_ocean/components/game_scene/ground_component.dart';
import 'package:save_the_ocean/components/game_scene/lighting_component.dart';
import 'package:save_the_ocean/components/game_scene/pipeline.dart';
import 'package:save_the_ocean/components/game_scene/timer_text_component.dart';
import 'package:save_the_ocean/components/game_scene/wall_component.dart';
import 'package:save_the_ocean/components/garbage/garbage_controller.dart';
import 'package:save_the_ocean/components/hub/hub.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/trash/trash.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';
import 'package:save_the_ocean/providers/game_providers.dart';
import 'package:save_the_ocean/providers/pollution_level_providers.dart';
import 'package:save_the_ocean/providers/robot_deploy_provider.dart';
import 'package:save_the_ocean/providers/robot_position_provider.dart';
import 'package:save_the_ocean/providers/robot_release_trash_providers.dart';

final screenSize = Vector2(2220, 1080);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);
final batteryLevelNotifier = BatteryLevelNotifier();
final pollutionLevelNotifier = PollutionLevelNotifier();
final robotPositionNotifier = RobotPositionNotifier();
final robotDeployNotifier = RobotDeployNotifier();
final robotReleaseTrashNotifier = RobotReleaseTrashNotifier();
final gameNotifier = GameNotifier();

class SaveTheOceanGame extends Forge2DGame {
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
    camera.moveTo(worldSize / 2);

    await addCameraElements();
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
    await loadSprite(ImageAssets.water);
    await loadSprite(ImageAssets.backgroundFar);
    await loadSprite(ImageAssets.backgroundFarMid);
    await loadSprite(ImageAssets.backgroundMid);
    await loadSprite(ImageAssets.backgroundMidFront);
    await loadSprite(ImageAssets.backgroundFront);
    await loadSprite(ImageAssets.foregroundBottom);
    await loadSprite(ImageAssets.foregroundLeftWall);
    await loadSprite(ImageAssets.foregroundRightWall);
    await loadSprite(ImageAssets.foregroundTopWall);
    await loadSprite(ImageAssets.pipeline);
    await loadSprite(ImageAssets.arm);
    await loadSprite(ImageAssets.claw);
    await loadSprite(ImageAssets.level);
    await loadSprite(ImageAssets.bottle);
    await loadSprite(ImageAssets.trash);
  }

  Future<void> addCameraElements() async {
    final parallaxImages = [
      ParallaxImageData(ImageAssets.water),
      ParallaxImageData(ImageAssets.backgroundFar),
      ParallaxImageData(ImageAssets.backgroundFarMid),
      ParallaxImageData(ImageAssets.backgroundMid),
      ParallaxImageData(ImageAssets.backgroundMidFront),
      ParallaxImageData(ImageAssets.backgroundFront),
    ];

    final parallax = await loadParallaxComponent(
      parallaxImages,
      velocityMultiplierDelta: Vector2(1.8, 1.0),
      size: Vector2(screenSize.x, screenSize.y),
      scale: Vector2(1.2, 1.2),
      filterQuality: FilterQuality.none,
    );

    camera.backdrop.addAll([parallax, FishesPositionComponent()]);
    camera.viewport.addAll([
      PipelineComponent(),
      ForegroundComponent.top(),
      ForegroundComponent.bottom(),
      ForegroundComponent.left(),
      ForegroundComponent.right(),
      HubFactory.create(),
      LightingPositionComponent(),
      TimerTextComponent(),
      FpsTextComponent(),
    ]);
  }

  void addWorldElements() async {
    world.addAll([
      Robot(),
      GroundBodyComponentFactory.create(),
      Trash(),
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
