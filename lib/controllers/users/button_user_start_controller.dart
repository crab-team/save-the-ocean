import 'package:flutter/foundation.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/domain/entities/user.dart';

enum ButtonUserStartStatus {
  initial,
  loading,
  success,
  notUserRegistered,
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

  void notUserRegistered() {
    _status = ButtonUserStartStatus.notUserRegistered;
    notifyListeners();
  }

  Future<void> onPress(String username) async {
    loading();
    try {
      User? user = await userController?.fetchByUsername(username);
      if (user != null) {
        await userController?.create(username);
        return;
      }

      success();
    } catch (e) {
      failure();
    }
  }
}
