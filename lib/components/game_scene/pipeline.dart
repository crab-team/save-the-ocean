import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class PipelineComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  @override
  Future<void> onLoad() async {
    sprite = Sprite(gameRef.images.fromCache(ImageAssets.pipeline));
    x = 0;
    y = gameRef.size.y / 3.2;
    width = 260;
    height = 220;
  }
}
