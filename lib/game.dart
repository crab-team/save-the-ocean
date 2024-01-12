import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/background.dart';
import 'package:save_the_ocean/components/garbage.dart';
import 'package:save_the_ocean/components/ground.dart';
import 'package:save_the_ocean/components/vacuum.dart';
import 'package:save_the_ocean/constants/assets.dart';

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
          gravity: Vector2(0, 15.0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await loadAssets();

    vacuum = await VacuumFactory.create();

    camera.backdrop.add(Background(size: screenSize));
    camera.viewport.add(FpsTextComponent());

    camera.moveTo(worldSize / 2);

    world.add(Ground());
    world.add(Garbage());

    // world.addAll(createBoundaries());
    // world.add(GarbageComponent());
    // world.add(joystick);

    // world.add(vacuum);
    // world.add(VaccumButton(vacuum: vacuum));
  }

  Future<void> loadAssets() async {
    await loadSprite(Assets.background);
  }
}
