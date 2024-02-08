import 'package:flame/components.dart';
import 'package:save_the_ocean/components/game_scene/pollution_water/pollution_water_rive_component.dart';

class PollutionWaterComponent extends PositionComponent {
  @override
  onLoad() async {
    final component = await PollutionWaterRiveComponentFactory.create();
    component.priority = 2;
    add(component);
  }
}
