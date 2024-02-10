import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';

enum ButtonUserStartStatus {
  initial,
  loading,
  success,
  failure,
}

class ButtonUserStartController extends ChangeNotifier {
  final UserController? userController;

  ButtonUserStartController({this.userController});

  ButtonUserStartStatus _status = ButtonUserStartStatus.initial;
  ButtonUserStartStatus get status => _status;

  void loading() {
    _status = ButtonUserStartStatus.loading;
    notifyListeners();
  }

  void success() {
    _status = ButtonUserStartStatus.success;
    notifyListeners();
  }

  void failure() {
    _status = ButtonUserStartStatus.failure;
    notifyListeners();
  }

  void initial() {
    _status = ButtonUserStartStatus.initial;
    notifyListeners();
  }

  Future<void> onPress(String username) async {
    loading();
    try {
      await userController?.create(username);
      success();
    } catch (e) {
      failure();
    }
  }
}
