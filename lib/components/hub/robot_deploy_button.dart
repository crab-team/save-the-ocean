import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class RobotDeployButtonSprite extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  final bool isPressed;

  RobotDeployButtonSprite({this.isPressed = false})
      : super(
          size: Vector2(200, 200),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = isPressed
        ? Sprite(gameRef.images.fromCache(ImageAssets.buttonDeployPressed))
        : Sprite(gameRef.images.fromCache(ImageAssets.buttonDeploy));
  }
}

class RobotDeployButton extends HudButtonComponent {
  RobotDeployButton()
      : super(
          button: CircleComponent(
            radius: 100,
            paint: BasicPalette.transparent.paint(),
            children: [RobotDeployButtonSprite()],
          ),
          buttonDown: CircleComponent(
            radius: 80,
            paint: BasicPalette.darkGreen.paint(),
            children: [RobotDeployButtonSprite(isPressed: true)],
          ),
        );

  @override
  Future<void> onLoad() {
    super.onPressed = () {
      !robotDeployController.deploy ? robotDeployController.deployRobot() : robotDeployController.refoldRobot();
    };
    return super.onLoad();
  }
}
