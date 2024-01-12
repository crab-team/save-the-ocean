import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/background.dart';
import 'package:save_the_ocean/components/garbage.dart';
import 'package:save_the_ocean/components/ground.dart';
import 'package:save_the_ocean/components/vacuum.dart';

final screenSize = Vector2(1280, 720);
final worldSize = Vector2(12.8, 7.2);

class SaveTheOceanGame extends Forge2DGame {
  late Vacuum vacuum;

  SaveTheOceanGame()
      : super(
          zoom: 100,
          cameraComponent: CameraComponent.withFixedResolution(
            width: screenSize.x,
            height: screenSize.y,
          ),
          gravity: Vector2(0, 10.0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    vacuum = await VacuumFactory.create();

    camera.viewport = FixedResolutionViewport(resolution: screenSize);
    camera.viewport.add(FpsTextComponent());

    camera.backdrop.add(Background(size: screenSize));

    world.addAll(createBoundaries());

    world.add(Ground());
    world.add(Garbage());

    // world.add(GarbageComponent());
    // world.add(joystick);

    // world.add(vacuum);
    // world.add(VaccumButton(vacuum: vacuum));
  }

  List<Component> createBoundaries() {
    final visibleRect = camera.visibleWorldRect;
    final topLeft = visibleRect.topLeft.toVector2();
    final topRight = visibleRect.topRight.toVector2();
    final bottomRight = visibleRect.bottomRight.toVector2();
    final bottomLeft = visibleRect.bottomLeft.toVector2();

    return [
      Wall(topLeft, topRight),
      Wall(topRight, bottomRight),
      Wall(bottomLeft, bottomRight),
      Wall(topLeft, bottomLeft),
    ];
  }
}

class Wall extends BodyComponent {
  final Vector2 _start;
  final Vector2 _end;

  Wall(this._start, this._end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(_start, _end);
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
