import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:save_the_ocean/components/background.dart';
import 'package:save_the_ocean/components/garbage.dart';
import 'package:save_the_ocean/components/ground.dart';
import 'package:save_the_ocean/components/vacuum.dart';
import 'package:save_the_ocean/components/vacuum_button.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

final screenSize = Vector2(1280, 720);
final worldSize = Vector2(12.8, 7.2);

class SaveTheOceanGame extends Forge2DGame {
  late RiveVacuum riveVacuum;

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
    riveVacuum = await RiveVacuumFactory.create();

    camera.moveTo(worldSize / 2);

    addCameraElements();
    addWorldElements();
  }

  Future<void> loadAssets() async {
    await loadSprite(ImageAssets.background);
  }

  void addCameraElements() {
    camera.backdrop.add(Background(size: screenSize));
    camera.viewport.add(FpsTextComponent());
    camera.viewport.add(joystick);
    camera.viewport.add(VaccumButton(vacuum: riveVacuum));
  }

  void addWorldElements() async {
    world.add(Ground());
    world.add(Garbage());
    world.add(Vacuum(vacuum: riveVacuum));
  }
}
