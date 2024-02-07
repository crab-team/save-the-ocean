import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class TrashSpriteComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  @override
  Future<void> onLoad() async {
    sprite = Sprite(gameRef.images.fromCache(ImageAssets.trash));
    width = 4;
    height = 3.44;
    anchor = Anchor.bottomCenter;
    x = 1.7;
  }
}
