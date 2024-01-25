import 'dart:async';

import 'package:flame/components.dart';
import 'package:save_the_ocean/game.dart';

class TimerTextComponent extends PositionComponent {
  TimerTextComponent() : super(position: Vector2(screenSize.x / 2, 10), size: Vector2(100, 100));

  double elapsedSecs = 0;
  late Timer interval;
  late TextComponent _textComponent;

  @override
  Future<FutureOr<void>> onLoad() async {
    await super.onLoad();
    interval = Timer(
      0.001,
      onTick: () {
        elapsedSecs += 0.001;
        _textComponent.text = getTimeFormatByDt(elapsedSecs);
      },
      repeat: true,
    );

    _textComponent = TextComponent(
      text: '00:00:000',
      position: Vector2.zero(),
      anchor: Anchor.topCenter,
    );
    add(_textComponent);
  }

  @override
  void update(double dt) {
    interval.update(dt);
  }

  String getTimeFormatByDt(double dt) {
    String minutes = getMinutes(dt);
    String seconds = getSeconds(dt);
    String milliseconds = getMilliseconds(dt);

    return '$minutes:$seconds:$milliseconds';
  }

  String getMinutes(double dt) {
    return (dt / 60).floor().toString().padLeft(2, '0');
  }

  String getSeconds(double dt) {
    return (dt % 60).floor().toString().padLeft(2, '0');
  }

  String getMilliseconds(double dt) {
    return ((dt * 1000) % 1000).floor().toString().padLeft(3, '0');
  }
}
