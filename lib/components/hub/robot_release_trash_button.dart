import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/screens/game_screen.dart';

class RobotReleaseTrashButtonSprite extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  final bool isPressed;

  RobotReleaseTrashButtonSprite({this.isPressed = false})
      : super(
          size: Vector2(200, 200),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = isPressed
        ? Sprite(gameRef.images.fromCache(ImageAssets.buttonCrawPressed))
        : Sprite(gameRef.images.fromCache(ImageAssets.buttonCraw));
  }
}

class RobotReleaseTrashButton extends ButtonComponent {
  RobotReleaseTrashButton()
      : super(
          button: CircleComponent(
            radius: 80,
            paint: BasicPalette.transparent.paint(),
            children: [RobotReleaseTrashButtonSprite()],
          ),
          buttonDown: CircleComponent(
            radius: 80,
            paint: BasicPalette.transparent.paint(),
            children: [RobotReleaseTrashButtonSprite(isPressed: true)],
          ),
        );

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    robotReleaseTrashNotifier.release();
  }
}
