import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class RobotClawSpriteComponent extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  RobotClawSpriteComponent()
      : super(
          size: Vector2(1.15, 1.55),
          anchor: Anchor.topCenter,
          position: Vector2(0, 0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = Sprite(gameRef.images.fromCache(ImageAssets.claw));
  }
}
