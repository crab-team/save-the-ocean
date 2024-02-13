import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game.dart';

enum ForegroundPosition { top, left, right, bottom }

class ForegroundComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  ForegroundPosition foregroundPosition = ForegroundPosition.top;

  ForegroundComponent.top({this.foregroundPosition = ForegroundPosition.top});
  ForegroundComponent.bottom({this.foregroundPosition = ForegroundPosition.bottom});
  ForegroundComponent.left({this.foregroundPosition = ForegroundPosition.left});
  ForegroundComponent.right({this.foregroundPosition = ForegroundPosition.right});

  @override
  Future<void> onLoad() async {
    switch (foregroundPosition) {
      case ForegroundPosition.top:
        sprite = Sprite(gameRef.images.fromCache(ImageAssets.foregroundTopWall));
        width = gameRef.size.x;
        height = gameRef.size.y / 2.3;
        break;
      case ForegroundPosition.bottom:
        sprite = Sprite(gameRef.images.fromCache(ImageAssets.foregroundBottom));
        width = gameRef.size.x;
        height = gameRef.size.y / 3.6;
        y = gameRef.size.y - height;
        break;
      case ForegroundPosition.left:
        sprite = Sprite(gameRef.images.fromCache(ImageAssets.foregroundLeftWall));
        width = 240;
        height = gameRef.size.y;
        x = 0;
        break;
      case ForegroundPosition.right:
        sprite = Sprite(gameRef.images.fromCache(ImageAssets.foregroundRightWall));
        width = 240;
        height = gameRef.size.y;
        x = gameRef.size.x - width;
        break;
    }
  }
}
