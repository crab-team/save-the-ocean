import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';
import 'package:save_the_ocean/screens/game_screen.dart';

class RudderJoystickButtonSprite extends SpriteComponent with HasGameRef<SaveTheOceanGame> {
  final bool isPressed;

  RudderJoystickButtonSprite({this.isPressed = false})
      : super(
          size: Vector2(200, 200),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = isPressed
        ? Sprite(gameRef.images.fromCache(ImageAssets.buttonDirectionPressed))
        : Sprite(gameRef.images.fromCache(ImageAssets.buttonDirection));
  }
}

class RudderJoystickButton extends ButtonComponent {
  final bool isLeft;
  RudderJoystickButton({this.isLeft = true})
      : super(
          position: Vector2(0, 0),
          size: Vector2(200, 200),
          button: RectangleComponent(
            size: Vector2(200, 200),
            paint: BasicPalette.transparent.paint(),
          ),
          buttonDown: RectangleComponent(
            size: Vector2(200, 200),
            paint: BasicPalette.transparent.paint(),
          ),
        );

  @override
  Future<FutureOr<void>> onLoad() async {
    await super.onLoad();
    final rudderJoystickButtonSprite = RudderJoystickButtonSprite();
    final rudderJoystickButtonPressedSprite = RudderJoystickButtonSprite(isPressed: true);
    if (!isLeft) {
      rudderJoystickButtonSprite.position.x = 200;
      rudderJoystickButtonSprite.flipHorizontally();
      rudderJoystickButtonPressedSprite.position.x = 200;
      rudderJoystickButtonPressedSprite.flipHorizontally();
    }
    button?.add(rudderJoystickButtonSprite);
    buttonDown?.add(rudderJoystickButtonPressedSprite);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (isLeft) {
      robotPositionNotifier.moveLeft();
    } else {
      robotPositionNotifier.moveRight();
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    robotPositionNotifier.stop();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    robotPositionNotifier.stop();
  }
}
