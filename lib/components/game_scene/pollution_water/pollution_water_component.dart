import 'package:flame/components.dart';
import 'package:save_the_ocean/components/game_scene/pollution_water/pollution_water_sprite_component.dart';
import 'package:save_the_ocean/screens/game/game_screen.dart';

class PollutionWaterComponent extends PositionComponent {
  @override
  onLoad() async {
    final spriteComponent = PollutionWaterSpriteComponent();
    spriteComponent.position = Vector2(0, 0);
    spriteComponent.priority = 2;
    spriteComponent.position = Vector2(0, 0);
    spriteComponent.opacity = 0;
    pollutionLevelController.addListener(() {
      spriteComponent.opacity = pollutionLevelController.level / 100;
    });
    add(spriteComponent);
  }
}
