import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/game_scene/trash/trash_sprite_component.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class TrashBoundaries extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x - 5.5, worldSize.y),
      type: BodyType.static,
    );

    final shape = ChainShape()
      ..createChain([
        Vector2(0.4, -5.5),
        Vector2(0.4, 0),
        Vector2(3, 0),
        Vector2(3, -5.5),
      ]);
    final fixtureDef = FixtureDef(shape);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final component = await TrashRiveComponentFactory.create();
    component.position = Vector2.zero();
    component.width = 3;
    component.height = 5.6;
    component.anchor = Anchor.bottomCenter;
    component.x = 1.7;
    add(component);
  }
}
