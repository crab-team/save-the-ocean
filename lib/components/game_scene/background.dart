import 'package:flame/components.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class Background extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  Background({super.size});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // sprite = Sprite(gameRef.images.fromCache(ImageAssets.background));
  }
}
