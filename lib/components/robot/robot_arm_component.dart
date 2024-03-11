import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/robot/robot_arm_breakage_sprite_component.dart';
import 'package:save_the_ocean/components/robot/robot_arm_sprite_component.dart';
import 'package:save_the_ocean/screens/game/game.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class RobotArmComponent extends BodyComponent {
  double initialPositionX = worldSize.x / 2;
  double initialPositionY = 1;

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(initialPositionX, initialPositionY),
      type: BodyType.kinematic,
    );
    return world.createBody(bodyDef);
  }

  @override
  Future<void> onLoad() async {
    renderBody = false;
    await super.onLoad();

    RobotArmSpriteComponent robotArmSpriteComponent = RobotArmSpriteComponent();
    robotArmSpriteComponent.y = -robotArmSpriteComponent.height + 0.1;
    RobotArmBreakageSpriteComponent robotArmBreakageSpriteComponent = RobotArmBreakageSpriteComponent();
    robotArmBreakageSpriteComponent.y = -robotArmBreakageSpriteComponent.height + 0.1;
    robotArmBreakageSpriteComponent.opacity = 0;
    breakageLevelController.addListener(() {
      robotArmBreakageSpriteComponent.opacity = 1 - breakageLevelController.level / 100;
    });
    add(robotArmSpriteComponent);
    add(robotArmBreakageSpriteComponent);
  }
}
