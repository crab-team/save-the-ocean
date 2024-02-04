import 'package:flame/components.dart';
import 'package:save_the_ocean/game.dart';

class ForegroundComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  final String path;

  ForegroundComponent({required this.path});

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(path);
    width = gameRef.size.x;
    height = gameRef.size.y;
  }
}
