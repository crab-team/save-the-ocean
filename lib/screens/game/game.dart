import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:save_the_ocean/components/game_scene/battery_level/battery_level_component.dart';
import 'package:save_the_ocean/components/game_scene/bubbles/bubbles_component.dart';
import 'package:save_the_ocean/components/game_scene/fishes_rive_component.dart';
import 'package:save_the_ocean/components/game_scene/foreground_component.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_controller.dart';
import 'package:save_the_ocean/components/game_scene/ground_component.dart';
import 'package:save_the_ocean/components/game_scene/lighting_component.dart';
import 'package:save_the_ocean/components/game_scene/pipeline.dart';
import 'package:save_the_ocean/components/game_scene/pollution_water/pollution_water_component.dart';
import 'package:save_the_ocean/components/game_scene/timer_text_component.dart';
import 'package:save_the_ocean/components/game_scene/trash/trash_boundaries.dart';
import 'package:save_the_ocean/components/game_scene/trash/trash_floor.dart';
import 'package:save_the_ocean/components/game_scene/wall_component.dart';
import 'package:save_the_ocean/components/hub/joystick.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/constants/app.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

final screenSize = Vector2(2220, 1080);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);

class SaveTheOceanGame extends Forge2DGame with KeyboardEvents {
  bool hasUserAlreadyRegistered = false;
  late GarbageController _garbageController;
  late Timer timer;
  late Timer garbageTimer;
  double elapsedTime = 0;

  SaveTheOceanGame()
      : super(
          zoom: cameraZoom,
          cameraComponent: CameraComponent.withFixedResolution(
            width: screenSize.x,
            height: screenSize.y,
          ),
          gravity: Vector2(0, 12.0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await loadAssets();

    initTimers();
    gameListeners();

    _garbageController = GarbageController(world);
    camera.moveTo(worldSize / 2);

    await addCameraElements();
    addWorldElements();
  }

  initTimers() {
    timer = Timer(
      0.001,
      onTick: () {
        elapsedTime += 0.001;
      },
      repeat: true,
    );

    garbageTimer = Timer(
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
    garbageTimer.update(dt);
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
    await loadSprite(ImageAssets.battery);
    await loadSprite(ImageAssets.beer);
    await loadSprite(ImageAssets.plastic);
    await loadSprite(ImageAssets.tire);
    await loadSprite(ImageAssets.trash);
    await loadSprite(ImageAssets.buttonDeploy);
    await loadSprite(ImageAssets.buttonDeployPressed);
    await loadSprite(ImageAssets.buttonCraw);
    await loadSprite(ImageAssets.buttonCrawPressed);
    await loadSprite(ImageAssets.buttonDirection);
    await loadSprite(ImageAssets.buttonDirectionPressed);
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
      BubblesPositionComponent(),
      ForegroundComponent.top(),
      ForegroundComponent.bottom(),
      ForegroundComponent.left(),
      ForegroundComponent.right(),
      JoystickFactory.create(),
      LightingPositionComponent(),
      PollutionWaterComponent(),
      TimerTextComponent(),
      FpsTextComponent(),
      BatteryLevelComponent(),
    ]);
  }

  void addWorldElements() async {
    world.addAll([
      Robot(),
      GroundBodyComponent(),
      TrashFloor(),
      TrashBoundaries(),
      WallComponent(isLeft: false),
      WallComponent(isLeft: true),
    ]);
  }

  void gameListeners() {
    batteryLevelController.addListener(() {
      if (batteryLevelController.level <= -500) {
        gameController.gameOver();
      }
    });

    pollutionLevelController.addListener(() {
      if (pollutionLevelController.level >= 500) {
        gameController.gameOver();
      }
    });

    gameController.addListener(() {
      if (gameController.isGameOver) {
        executeGameOver();
      } else {
        executeRestartGame();
      }
    });
  }

  void executeGameOver() {
    overlays.add(AppConstants.gameOverDialog);
    pauseEngine();
  }

  void executeRestartGame() {
    overlays.remove(AppConstants.gameOverDialog);
    restart();
  }

  void togglePauseGame() {
    print(overlays.isActive(AppConstants.pauseDialog));
    if (overlays.isActive(AppConstants.pauseDialog)) {
      overlays.remove(AppConstants.pauseDialog);
      resumeEngine();
    } else {
      overlays.add(AppConstants.pauseDialog);
      pauseEngine();
    }
  }

  void restart() {
    elapsedTime = 0;
    timer.stop();
    garbageTimer.stop();
    pollutionLevelController.restart();
    batteryLevelController.restart();
    world.removeAll(world.children);
    addWorldElements();
    timer.start();
    garbageTimer.start();
    resumeEngine();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyUp = event is RawKeyUpEvent;
    final isKeyA = event.logicalKey == LogicalKeyboardKey.keyA;
    final isKeyD = event.logicalKey == LogicalKeyboardKey.keyD;
    final isKeyK = event.logicalKey == LogicalKeyboardKey.keyK;
    final isKeyL = event.logicalKey == LogicalKeyboardKey.keyL;
    final isKeyEsc = event.logicalKey == LogicalKeyboardKey.escape;
    if (!event.repeat) {
      if (isKeyA) {
        robotPositionController.moveLeft();
      }

      if (isKeyD) {
        robotPositionController.moveRight();
      }

      if (isKeyA && isKeyUp || isKeyD && isKeyUp) {
        robotPositionController.stop();
      }
    }

    if (isKeyK && !isKeyUp) {
      !robotDeployController.deploy ? robotDeployController.deployRobot() : robotDeployController.refoldRobot();
    }

    if (isKeyL && !isKeyUp) {
      robotReleaseGarbageController.release();
    }

    if (isKeyEsc && !isKeyUp) {
      togglePauseGame();
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
