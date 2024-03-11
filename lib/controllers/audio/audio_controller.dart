import 'package:flutter/material.dart';

class AudioController extends ChangeNotifier {
  bool _isAllowed = false;

  bool get isAllowed => _isAllowed;

  set isAllowed(bool value) {
    _isAllowed = value;
    notifyListeners();
  }
}
