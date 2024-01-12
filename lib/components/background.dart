import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Assets.background);
    size = gameRef.size;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    this.size = size;
  }
}
