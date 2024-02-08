import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class RobotArmSpriteComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  RobotArmSpriteComponent()
      : super(
          size: Vector2(0.94, 10.8),
          anchor: Anchor.topCenter,
          position: Vector2(0, 0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = Sprite(gameRef.images.fromCache(ImageAssets.arm));
  }
}
