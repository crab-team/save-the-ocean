import 'package:flame/components.dart';
import 'package:save_the_ocean/constants/assets.dart';

class Background extends SpriteComponent {
  Background({super.size});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load(Assets.background);
  }
}
