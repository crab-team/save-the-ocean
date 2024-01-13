import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/components/vacuum.dart';

class VaccumButton extends HudButtonComponent {
  final RiveVacuum vacuum;

  VaccumButton({required this.vacuum})
      : super(
          button: CircleComponent(radius: 35, anchor: Anchor.center, paint: BasicPalette.red.paint()),
          buttonDown: CircleComponent(radius: 40, anchor: Anchor.center, paint: BasicPalette.red.paint()),
          margin: const EdgeInsets.only(bottom: 50, right: 50),
          onPressed: () => vacuum.aspire(),
        );
}
