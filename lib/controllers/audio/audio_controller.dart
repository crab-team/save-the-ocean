import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class AudioController extends ChangeNotifier {
  bool _isMuted = false;
  bool _isAllowed = false;

  bool get isMuted => _isMuted;
  bool get isAllowed => _isAllowed;

  set isAllowed(bool value) {
    _isAllowed = value;
    notifyListeners();
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    if (_isMuted) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void play() {
    FlameAudio.bgm.play('save_the_ocean.mp3', volume: 0.2);
  }

  void pause() {
    FlameAudio.bgm.pause();
  }

  void stop() {
    FlameAudio.bgm.stop();
  }

  void resume() {
    FlameAudio.bgm.resume();
  }

  void playSfx(String sfx) {}

  void pauseSfx(String sfx) {}

  void initSfx() {}
}
