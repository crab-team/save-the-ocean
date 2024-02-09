import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/screens/game_screen.dart';

class RobotDeployButton extends HudButtonComponent {
  RobotDeployButton()
      : super(
          button: CircleComponent(
            radius: 80,
            paint: BasicPalette.green.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 80,
            paint: BasicPalette.darkGreen.paint(),
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
      radius: 80,
      paint: robotDeployNotifier.deploy ? BasicPalette.red.paint() : BasicPalette.orange.paint(),
    );
  }
}
