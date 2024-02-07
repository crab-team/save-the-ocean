import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class PipelineComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(ImageAssets.pipeline);
    x = 0;
    y = gameRef.size.y / 2.8;
    width = 250;
    height = 190;
  }
}
