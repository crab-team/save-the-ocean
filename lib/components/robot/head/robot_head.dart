import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/robot/head/rive_robot_head.dart';

class RobotHead extends PositionComponent {
  final RiveRobotHead riveHead;

  RobotHead({required this.riveHead});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
    add(riveHead);
  }

  void aspire() {
    riveHead.aspire();
  }
}
