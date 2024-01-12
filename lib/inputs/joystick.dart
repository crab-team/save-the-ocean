import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 50,
    paint: BasicPalette.blue.withAlpha(200).paint(),
  ),
  background: CircleComponent(
    radius: 100,
    paint: BasicPalette.blue.withAlpha(200).paint(),
  ),
  margin: const EdgeInsets.only(left: 48, bottom: 48),
);
