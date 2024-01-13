import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/game.dart';

JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 35,
    paint: BasicPalette.black.withAlpha(200).paint(),
  ),
  background: CircleComponent(
    radius: 75,
    paint: BasicPalette.gray.withAlpha(200).paint(),
  ),
  position: Vector2(120, screenSize.y - 100),
);
