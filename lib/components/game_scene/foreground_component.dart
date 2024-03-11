import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class ForegroundComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  @override
  Future<void> onLoad() async {
    sprite = Sprite(gameRef.images.fromCache(ImageAssets.foreground));
    width = gameRef.size.x;
    height = gameRef.size.y;
  }
}
