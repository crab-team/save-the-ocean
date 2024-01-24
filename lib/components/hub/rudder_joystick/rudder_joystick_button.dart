import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';
import 'package:save_the_ocean/game.dart';

class RudderJoystickButton extends ButtonComponent {
  final bool isLeft;
  RudderJoystickButton({this.isLeft = true})
      : super(
          position: Vector2(0, 0),
          size: Vector2(100, 100),
          button: RectangleComponent(
            size: Vector2(100, 100),
            paint: BasicPalette.black.paint(),
          ),
          buttonDown: RectangleComponent(
            size: Vector2(100, 100),
            paint: BasicPalette.darkGray.paint(),
          ),
        );

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (isLeft) {
      robotNotifier.moveLeft();
    } else {
      robotNotifier.moveRight();
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    robotNotifier.stop();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    robotNotifier.stop();
  }
}
