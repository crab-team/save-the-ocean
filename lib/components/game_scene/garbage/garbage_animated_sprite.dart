import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:save_the_ocean/screens/game/game.dart';

class GarbageSpriteAnimation extends SpriteAnimationComponent with HasGameRef<SaveTheOceanGame> {
  final Vector2 spriteSize;
  final Vector2 spritePosition;
  final String spriteSheet;
  final String sprite;

  GarbageSpriteAnimation({
    required this.spriteSheet,
    required this.sprite,
    required this.spriteSize,
    required this.spritePosition,
  }) : super(size: spriteSize, position: spritePosition);

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    final sheet = SpriteSheet(
      image: gameRef.images.fromCache(spriteSheet),
      srcSize: Vector2(350, 300),
    );

    final animation = sheet.createAnimation(row: 0, stepTime: 0.5, to: 2, loop: true);
    final component = SpriteAnimationComponent(
        animation: animation, position: Vector2.zero(), size: spriteSize, anchor: Anchor.center);

    add(component);
  }
}
