import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/game.dart';

class RobotDeployButton extends HudButtonComponent {
  RobotDeployButton()
      : super(
          button: CircleComponent(
            radius: 50,
            paint: BasicPalette.orange.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 50,
            paint: BasicPalette.darkRed.paint(),
          ),
        );

  @override
  Future<void> onLoad() {
    super.onPressed = () {
      !robotDeployNotifier.deploy ? robotDeployNotifier.deployRobot() : robotDeployNotifier.refoldRobot();
    };
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    super.button = CircleComponent(
      radius: 50,
      paint: robotDeployNotifier.deploy ? BasicPalette.red.paint() : BasicPalette.orange.paint(),
    );
  }
}
