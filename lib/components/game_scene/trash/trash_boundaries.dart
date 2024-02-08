import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/game_scene/trash/trash_sprite_component.dart';
import 'package:save_the_ocean/game.dart';

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

    final sprite = TrashSpriteComponent();
    add(sprite);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
