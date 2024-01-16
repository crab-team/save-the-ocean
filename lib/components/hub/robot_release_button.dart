import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';

class RobotReleaseButton extends HudButtonComponent {
  @override
  Future<void> onLoad() {
    debugMode = kDebugMode;
    return super.onLoad();
  }
}
