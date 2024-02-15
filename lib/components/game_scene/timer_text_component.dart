import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/screens/game/game.dart';
import 'package:save_the_ocean/utils/score.dart';

class TimerTextComponent extends PositionComponent with HasGameRef<SaveTheOceanGame> {
  TimerTextComponent() : super(position: Vector2(380, 130), size: Vector2(100, 100));

  double elapsedSecs = 0;
  late TextComponent _textComponent;
  late TextComponent _textRecyclingTimeComponent;

  @override
  Future<FutureOr<void>> onLoad() async {
    await super.onLoad();
    _textRecyclingTimeComponent = TextComponent(
      text: 'Recycling time:',
      position: Vector2.zero(),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36.0, color: Color.fromRGBO(2, 51, 74, 1), fontFamily: 'ProtestRiot'),
      ),
    );

    _textComponent = TextComponent(
      text: '00:00:000',
      position: Vector2(220, 0),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 36.0, color: Color.fromRGBO(2, 51, 74, 1), fontFamily: 'ProtestRiot'),
      ),
    );

    add(_textRecyclingTimeComponent);
    add(_textComponent);
  }

  @override
  void update(double dt) {
    _textComponent.text = ScoreUtils.getTimeFormat(gameRef.elapsedTime);
  }
}
