import 'package:flutter/foundation.dart';

class RobotReleaseGarbageController extends ChangeNotifier {
  bool _released = false;

  bool get released => _released;

  void release() {
    if (_released) {
      _released = false;
      notifyListeners();
      return;
    }
    _released = true;
    notifyListeners();
  }
}
