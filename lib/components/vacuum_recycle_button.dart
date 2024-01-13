import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/components/vacuum.dart';

class VacuumRecycleButton extends HudButtonComponent {
  final Vacuum vacuum;

  VacuumRecycleButton({required this.vacuum})
      : super(
          button: CircleComponent(
            radius: 50,
            paint: BasicPalette.red.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 50,
            paint: BasicPalette.darkRed.paint(),
          ),
          margin: const EdgeInsets.only(right: 48, bottom: 32),
          onPressed: () => vacuum.aspire(),
        );

  @override
  Future<void> onLoad() {
    debugMode = kDebugMode;
    return super.onLoad();
  }
}
