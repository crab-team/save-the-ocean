import 'package:flame/components.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class GarbageSpriteComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  final String path;

  GarbageSpriteComponent({required this.path})
      : super(
          anchor: Anchor.center,
          position: Vector2(0, 0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = Sprite(gameRef.images.fromCache(path));
  }
}
