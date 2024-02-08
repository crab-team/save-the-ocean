import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/game.dart';

class RobotReleaseTrashButton extends ButtonComponent {
  RobotReleaseTrashButton()
      : super(
          button: CircleComponent(
            radius: 80,
            paint: BasicPalette.red.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 80,
            paint: BasicPalette.darkRed.paint(),
          ),
        );

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    robotReleaseTrashNotifier.release();
  }
}
