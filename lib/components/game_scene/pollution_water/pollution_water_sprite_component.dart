import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class PollutionWaterSpriteComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  PollutionWaterSpriteComponent()
      : super(
          size: Vector2(screenSize.x, screenSize.y),
          position: Vector2(0, 0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = Sprite(gameRef.images.fromCache(ImageAssets.pollutionWater));
  }
}
