import 'package:flutter/foundation.dart';

class RobotReleaseGarbageController extends ChangeNotifier {
  bool _released = false;
  bool _isFreezed = false;

  bool get released => _released;
  bool get isFreezed => _isFreezed;

  set isFreezed(bool value) {
    _isFreezed = value;
    notifyListeners();
  }

  void release() {
    if (_isFreezed) return;

    if (_released) {
      _released = false;
      notifyListeners();
      return;
    }
    _released = true;
    notifyListeners();
  }
}
