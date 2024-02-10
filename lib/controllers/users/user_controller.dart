import 'package:flutter/material.dart';
import 'package:save_the_ocean/controllers/users/user_error.dart';
import 'package:save_the_ocean/controllers/users/user_state.dart';
import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/use_cases/users/create_user.dart';
import 'package:save_the_ocean/domain/use_cases/users/get_user.dart';
import 'package:save_the_ocean/domain/use_cases/users/get_user_by_username.dart';
import 'package:save_the_ocean/domain/use_cases/users/update_user.dart';

class UserController extends ChangeNotifier {
  final GetUser getUser;
  final GetUserByUsername getUserByUsername;
  final CreateUser createUser;
  final UpdateUserScore updateUserScore;

  UserController(
      {required this.getUser,
      required this.createUser,
      required this.updateUserScore,
      required this.getUserByUsername});

  UserControllerState _currentState = UserControllerState.initial();
  UserControllerState get currentState => _currentState;
  User? _user;
  User? get currentUser => _user;

  set currentUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> fetchByUsername(String username) async {
    loading();
    try {
      final User user = await getUserByUsername.call(username);
      currentUser = user;
      success();
    } on UserNotFound {
      notUserRegistered();
    } catch (e) {
      failure(e as Exception);
    }
  }

  Future<void> fetch() async {
    loading();
    try {
      final User user = await getUser.call();
      currentUser = user;
      success();
    } on NoUsernameLocally {
      notUsernameLocally();
    } catch (e) {
      failure(e as Exception);
    }
  }

  Future<void> create(String username) async {
    try {
      User user = await createUser.call(username);
      currentUser = user;
      success();
    } catch (e) {
      failure(e as Exception);
    }
  }

  Future<void> updateScore(double newScore) async {
    loading();
    try {
      print("newScore: $newScore");
      print("currentUser?.score: ${currentUser?.score}");
      if (currentUser == null) return success();
      if (currentUser!.score > newScore) return success();
      User user = await updateUserScore.call(currentUser!.username, newScore);
      currentUser = user;
      success();
    } on UserNotFound {
      notUserRegistered();
    } catch (e) {
      failure(e as Exception);
    }
  }

  loading() {
    _currentState = UserControllerState.loading();
    notifyListeners();
  }

  notUserRegistered() {
    _currentState = UserControllerState.notUserRegistered();
    notifyListeners();
  }

  notUsernameLocally() {
    _currentState = UserControllerState.notUsernameLocally();
    notifyListeners();
  }

  failure(Exception e) {
    _currentState = UserControllerState.failure(e);
    notifyListeners();
  }

  success() {
    _currentState = UserControllerState.success();
    notifyListeners();
  }
}
