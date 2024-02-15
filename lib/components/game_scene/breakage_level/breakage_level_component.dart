import 'package:flame/components.dart';
import 'package:save_the_ocean/components/game_scene/breakage_level/breakage_level_rive_component.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class BreakageLevelComponent extends PositionComponent {
  @override
  onLoad() async {
    await initBreakageLevel();
  }

  Future<void> initBreakageLevel() async {
    final component = await BreakageLevelRiveComponentFactory.create();
    component.size = Vector2(600, 100);
    component.position = Vector2(screenSize.x - component.size.x - 140, 80);
    add(component);
  }
}
