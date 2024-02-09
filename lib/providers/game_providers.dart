import 'package:flutter/foundation.dart';

class GameNotifier extends ChangeNotifier {
  bool _isGameOver = false;

  bool get isGameOver => _isGameOver;

  void gameOver() {
    _isGameOver = true;
    notifyListeners();
  }

  void restartGame() {
    _isGameOver = false;
    notifyListeners();
  }
}
