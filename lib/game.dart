import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/battery_level/battery_level.dart';
import 'package:save_the_ocean/components/battery_level/battery_level_controller.dart';
import 'package:save_the_ocean/components/game_scene/background.dart';
import 'package:save_the_ocean/components/game_scene/ground.dart';
import 'package:save_the_ocean/components/game_scene/left_wall.dart';
import 'package:save_the_ocean/components/game_scene/right_wall.dart';
import 'package:save_the_ocean/components/garbage/garbage_controller.dart';
import 'package:save_the_ocean/components/hub/robot_deploy_button.dart';
import 'package:save_the_ocean/components/hub/robot_release_joystick.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/components/robot/robot_factory.dart';
import 'package:save_the_ocean/components/trash/trash.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

final screenSize = Vector2(1280, 720);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);

class SaveTheOceanGame extends Forge2DGame {
  late Robot robot;
  late BatteryLevelComponent batteryLevel;
  late RobotClaw leftClaw;
  late RobotClaw rightClaw;
  late GarbageController _garbageController;
  late BatteryLevelController _batteryLevelController;

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
    batteryLevel = await BatteryLevelComponentFactory.create(_batteryLevelController);
    _batteryLevelController = BatteryLevelController(batteryLevel);
    robot = await RobotFactory.create();
    leftClaw = RobotClaw(isLeft: true);
    rightClaw = RobotClaw(isLeft: false);

    camera.moveTo(worldSize / 2);

    addCameraElements();
    addWorldElements();
  }

  Future<void> loadAssets() async {
    await loadSprite(ImageAssets.background);
  }

  void addCameraElements() {
    camera.backdrop.add(Background(size: screenSize));
    camera.viewport.addAll([
      FpsTextComponent(),
      batteryLevel,
      joystick,
      robotReleaseJoystick,
      RobotDeployButton(robot: robot, leftClaw: leftClaw, rightClaw: rightClaw),
    ]);
  }

  void addWorldElements() async {
    _garbageController.createGarbagesRamdomly();
    _batteryLevelController.decrementBatteryLevel();

    world.addAll([
      Ground(),
      LeftWall(),
      RightWall(),
      // robot,
      leftClaw,
      rightClaw,
      Trash(batteryLevelController: _batteryLevelController),
    ]);
  }
}
