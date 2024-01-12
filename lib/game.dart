import 'package:flame/game.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/components/vacuum_button.dart';
import 'package:save_the_ocean/components/background.dart';
import 'package:save_the_ocean/components/vacuum.dart';
import 'package:save_the_ocean/inputs/joystick.dart';

class SaveTheOceanGame extends FlameGame {
  late Vacuum vacuum;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final artboard =
        await loadArtboard(RiveFile.asset('assets/animations/save_the_ocean.riv'), artboardName: 'recycler');
    vacuum = Vacuum(artboard: artboard);

    add(BackgroundComponent());
    add(joystick);

    add(vacuum);
    add(VaccumButton(vacuum: vacuum));
  }
}
