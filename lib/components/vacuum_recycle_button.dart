import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/components/vacuum.dart';
import 'package:save_the_ocean/game.dart';

class VacuumRecycleButton extends HudButtonComponent {
  final Vacuum vacuum;

  VacuumRecycleButton({required this.vacuum})
      : super(
          button: CircleComponent(
            radius: 50,
            // anchor: Anchor.center,
            paint: BasicPalette.red.paint(),
          ),
          buttonDown: CircleComponent(
            radius: 45,
            // anchor: Anchor.center,
            paint: BasicPalette.red.paint(),
          ),
          // anchor: Anchor.center,
          position: Vector2(screenSize.x - 120, screenSize.y - 125),
          onPressed: () => vacuum.aspire(),
        );
}
