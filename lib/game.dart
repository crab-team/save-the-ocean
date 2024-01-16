import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/background.dart';
import 'package:save_the_ocean/components/garbage.dart';
import 'package:save_the_ocean/components/ground.dart';
import 'package:save_the_ocean/components/right_wall.dart';
import 'package:save_the_ocean/components/robot/robot_claw.dart';
import 'package:save_the_ocean/components/robot/robot_factory.dart';
import 'package:save_the_ocean/components/hub/robot_deploy_button.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/left_wall.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

final screenSize = Vector2(1280, 720);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);

class SaveTheOceanGame extends Forge2DGame {
  late Robot robot;
  late RobotClaw leftClaw;
  late RobotClaw rightClaw;

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
      joystick,
      RobotDeployButton(robot: robot, leftClaw: leftClaw, rightClaw: rightClaw),
    ]);
  }

  void addWorldElements() async {
    _createGarbagesRamdomly();

    world.addAll([
      Ground(),
      LeftWall(),
      RightWall(),
      robot,
      leftClaw,
      rightClaw,
    ]);
  }

  void _createGarbagesRamdomly() {
    for (var i = 0; i < 25; i++) {
      Future.delayed(Duration(seconds: i + 1), () {
        Random random = Random.secure();
        double randomNumber = random.nextDouble() * 6;

        final garbage = Garbage(
          initialLinearVelocityX: randomNumber + 2,
          initialAngularVelocity: randomNumber,
          fromLeft: Random().nextBool(),
        );
        world.add(garbage);
      });
    }
  }
}
