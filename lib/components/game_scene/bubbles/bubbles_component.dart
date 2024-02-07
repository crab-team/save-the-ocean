import 'package:flame/components.dart';
import 'package:save_the_ocean/components/game_scene/bubbles/bubbles_rive_component.dart';

class BubblesPositionComponent extends PositionComponent {
  @override
  onLoad() async {
    final component = await BubblesRiveComponentFactory.create();
    add(component);
  }
}
