import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/components/hub/rudder_joystick/rudder_joystick_button.dart';

class RudderJoystick extends PositionComponent {
  RudderJoystick();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = kDebugMode;
    initRudderJoystick();
  }

  void initRudderJoystick() {
    RudderJoystickButton rudderJoystickLeft = RudderJoystickButton();
    RudderJoystickButton rudderJoystickRight = RudderJoystickButton(isLeft: false);
    rudderJoystickLeft.position = Vector2(0, 10);
    rudderJoystickRight.position = Vector2(size.x - rudderJoystickRight.size.x, 10);
    add(rudderJoystickLeft);
    add(rudderJoystickRight);
  }
}
