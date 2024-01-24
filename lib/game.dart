import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/game_scene/background.dart';
import 'package:save_the_ocean/components/game_scene/ground.dart';
import 'package:save_the_ocean/components/game_scene/left_wall.dart';
import 'package:save_the_ocean/components/game_scene/right_wall.dart';
import 'package:save_the_ocean/components/garbage/garbage_controller.dart';
import 'package:save_the_ocean/components/hub/hub.dart';
import 'package:save_the_ocean/components/hub/robot_deploy_button.dart';
import 'package:save_the_ocean/components/hub/robot_release_joystick.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/components/robot/robot_factory.dart';
import 'package:save_the_ocean/components/trash/trash.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/inputs/joystick.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';
import 'package:save_the_ocean/providers/pollution_level_providers.dart';

final screenSize = Vector2(1280, 720);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);
final batteryLevelNotifier = BatteryLevelNotifier();
final pollutionLevelNotifier = PollutionLevelNotifier();

class SaveTheOceanGame extends Forge2DGame {
  late Robot robot;
  late RobotClaw leftClaw;
  late RobotClaw rightClaw;
  late GarbageController _garbageController;
  late TimerComponent timer;
  final TextBoxConfig textConfig = TextBoxConfig();

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
    leftClaw = RobotClaw(isLeft: true);
    rightClaw = RobotClaw(isLeft: false);

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
      Hub(),
      FpsTextComponent(),
      joystick,
      robotReleaseJoystick,
      RobotDeployButton(robot: robot, leftClaw: leftClaw, rightClaw: rightClaw),
    ]);
  }

  void addWorldElements() async {
    _garbageController.createGarbagesRamdomly();

    world.addAll([
      Ground(),
      LeftWall(),
      RightWall(),
      // robot,
      leftClaw,
      rightClaw,
      Trash(),
      TimerComponent(
          period: 1,
          autoStart: true,
          repeat: true,
          onTick: () {
            print('timer tick');
            if (batteryLevelNotifier.level > 0) batteryLevelNotifier.level -= 2;
          })
    ]);
  }
}
