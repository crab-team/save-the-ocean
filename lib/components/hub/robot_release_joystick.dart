import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/game.dart';

JoystickComponent robotReleaseJoystick = JoystickComponent(
  knob: CircleComponent(
    radius: 25,
    paint: BasicPalette.black.withAlpha(200).paint(),
  ),
  background: CircleComponent(
    radius: 55,
    paint: BasicPalette.gray.withAlpha(200).paint(),
  ),
  position: Vector2(screenSize.x - 80, screenSize.y - 80),
);
