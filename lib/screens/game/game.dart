import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:save_the_ocean/components/game_scene/battery_level/battery_level_component.dart';
import 'package:save_the_ocean/components/game_scene/breakage_level/breakage_level_component.dart';
import 'package:save_the_ocean/components/game_scene/bubbles/bubbles_component.dart';
import 'package:save_the_ocean/components/game_scene/foreground_component.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_controller.dart';
import 'package:save_the_ocean/components/game_scene/ground_component.dart';
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
  bool isFirstTime = true;

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

    if (isFirstTime) {
      overlays.add(AppConstants.tutorialDialog);
      isFirstTime = false;
    }

    await loadAssets();

    initTimers();
    gameListeners();

    _garbageController = GarbageController(world, this);
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
    await loadSprite(ImageAssets.foreground);
    await loadSprite(ImageAssets.pipeline);
    await loadSprite(ImageAssets.arm);
    await loadSprite(ImageAssets.armBreakage);
    await loadSprite(ImageAssets.claw);
    await loadSprite(ImageAssets.level);
    await loadSprite(ImageAssets.bottle);
    await loadSprite(ImageAssets.battery);
    await loadSprite(ImageAssets.beer);
    await loadSprite(ImageAssets.tools);
    await loadSprite(ImageAssets.plastic);
    await loadSprite(ImageAssets.tire);
    await loadSprite(ImageAssets.trash);
    await loadSprite(ImageAssets.buttonDeploy);
    await loadSprite(ImageAssets.buttonDeployPressed);
    await loadSprite(ImageAssets.buttonCraw);
    await loadSprite(ImageAssets.buttonCrawPressed);
    await loadSprite(ImageAssets.buttonDirection);
    await loadSprite(ImageAssets.buttonDirectionPressed);
    await loadSprite(ImageAssets.pollutionWater);
    await loadSprite(AnimationAssets.toolsSpriteSheet);
    await loadSprite(AnimationAssets.batterySpriteSheet);
  }

  Future<void> addCameraElements() async {
    camera.viewport.addAll([
      PipelineComponent(),
      BubblesPositionComponent(),
      ForegroundComponent(),
      PollutionWaterComponent(),
      JoystickFactory.create(),
      TimerTextComponent(),
      FpsTextComponent(),
      BatteryLevelComponent(),
      BreakageLevelComponent(),
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
      if (batteryLevelController.level <= 0 || breakageLevelController.isBroken) {
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
    breakageLevelController.restart();
    world.removeAll(world.children);
    addWorldElements();
    timer.start();
    garbageTimer.start();
    resumeEngine();
  }

  @override
  KeyEventResult onKeyEvent(event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyUp = event is KeyUpEvent;
    final isKeyDown = event is RawKeyDownEvent;
    final isKeyA = event.logicalKey == LogicalKeyboardKey.keyA;
    final isKeyD = event.logicalKey == LogicalKeyboardKey.keyD;
    final isKeyK = event.logicalKey == LogicalKeyboardKey.keyK;
    final isKeyL = event.logicalKey == LogicalKeyboardKey.keyL;
    final isKeyEsc = event.logicalKey == LogicalKeyboardKey.escape;
    final isAlreadyPressed = keysPressed.contains(event.logicalKey);

    if (isKeyA && isKeyDown) {
      if (!isAlreadyPressed) {
        robotPositionController.moveLeft();
      }
      return KeyEventResult.handled;
    }

    if (isKeyD && isKeyDown && !isAlreadyPressed) {
      robotPositionController.moveRight();
      return KeyEventResult.handled;
    }

    if (isKeyK && !isAlreadyPressed) {
      !robotDeployController.deploy ? robotDeployController.deployRobot() : robotDeployController.refoldRobot();
      return KeyEventResult.handled;
    }

    if (isKeyL && isKeyDown && !isAlreadyPressed) {
      robotReleaseGarbageController.release();
      return KeyEventResult.handled;
    }

    if (isKeyEsc && isKeyDown && !isAlreadyPressed) {
      togglePauseGame();
      return KeyEventResult.handled;
    }

    keysPressed.clear();
    robotPositionController.stop();
    return KeyEventResult.ignored;
  }
}
