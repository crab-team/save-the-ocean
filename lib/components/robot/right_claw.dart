import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/utils/logger.dart';

class RightClaw extends BodyComponent with ContactCallbacks {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(0, 0),
      angle: 11.4,
      type: BodyType.kinematic,
    );

    final armShape = ChainShape()
      ..createChain([
        Vector2(0, 0),
        Vector2(1 / 2, 1.2 / 2),
        Vector2(0, 2.2 / 2),
        Vector2(-0.5 / 2, 2.1 / 2),
      ]);

    final fixtureDef = FixtureDef(armShape, friction: 0.9);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  set onBeginContact(void Function(Object other, Contact contact)? onBeginContact) {
    super.onBeginContact = onBeginContact;

    Logger.log('Contacte');
  }
}
