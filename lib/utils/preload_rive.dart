import 'package:flame_rive/flame_rive.dart';
import 'package:save_the_ocean/components/game_scene/battery_level/battery_level_rive_component.dart';
import 'package:save_the_ocean/components/game_scene/garbage/garbage_rive_component.dart';
import 'package:save_the_ocean/constants/assets.dart';

class RiveAnimationProvider {
  final _fishAnimation = const RiveAnimation.asset(
    AnimationAssets.riv,
    artboard: ArtboardNames.fish,
  );

  RiveAnimation get fishRiveAnimation => _fishAnimation;

  final _mtcPresentation = const RiveAnimation.asset(
    AnimationAssets.riv,
    artboard: ArtboardNames.mtcPresentation,
  );

  RiveAnimation get mtcPresentationAnimation => _mtcPresentation;

  final _introductionScreen = const RiveAnimation.asset(
    AnimationAssets.riv,
    artboard: ArtboardNames.introductionScreen,
  );

  RiveAnimation get introductionScreenAnimation => _introductionScreen;

  final _toolsAnimationComponent = GarbageRiveComponentFactory(artboardName: ArtboardNames.tools).create();

  Future<RiveComponent> get toolsAnimationComponent => _toolsAnimationComponent;

  final _batteryAnimationComponent = GarbageRiveComponentFactory(artboardName: ArtboardNames.battery).create();

  Future<RiveComponent> get batteryAnimationComponent => _batteryAnimationComponent;

  final _batteryLevelAnimationComponent = BatteryLevelRiveComponentFactory.create();

  Future<BatteryLevelRiveComponent> get batteryLevelAnimationComponent => _batteryLevelAnimationComponent;

  final _breakageLevelAnimationComponent =
      GarbageRiveComponentFactory(artboardName: ArtboardNames.breakageLevel).create();

  Future<RiveComponent> get breakageLevelAnimationComponent => _breakageLevelAnimationComponent;
}
