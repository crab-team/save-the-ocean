import 'package:flutter/material.dart';
import 'package:save_the_ocean/controllers/users/user_error.dart';
import 'package:save_the_ocean/controllers/users/user_state.dart';
import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/use_cases/users/create_user.dart';
import 'package:save_the_ocean/domain/use_cases/users/get_user.dart';
import 'package:save_the_ocean/domain/use_cases/users/update_user.dart';

class UserController extends ChangeNotifier {
  final GetUser getUser;
  final CreateUser createUser;
  final UpdateUserScore updateUserScore;

  UserController({required this.getUser, required this.createUser, required this.updateUserScore});

  UserState _currentState = UserState.initial();
  UserState get currentState => _currentState;
  String _userId = '';
  String get userId => _userId;

  Future<void> fetch() async {
    print('fetch');
    _currentState = UserState.loading();
    try {
      final User user = await getUser.call();
      print('user: $user');
      _currentState = UserState.success(user);
      _userId = user.username;
    } on NoUsernameLocally {
      _currentState = UserState.notUsernameLocally();
    } on UserNotFound {
      _currentState = UserState.notUserRegistered();
    } catch (e) {
      _currentState = UserState.failure(e as Exception);
    }

    notifyListeners();
  }

  Future<void> create(String username) async {
    _currentState = UserState.loading();
    try {
      User user = await createUser.call(username);
      _currentState = UserState.success(user);
    } on UserAlreadyExists {
      _currentState = UserState.userAlreadyExists();
    } catch (e) {
      _currentState = UserState.failure(e as Exception);
    }
    notifyListeners();
  }

  Future<void> updateScore(int newScore) async {
    _currentState = UserState.loading();
    try {
      User user = await updateUserScore.call(newScore);
      _currentState = UserState.success(user);
    } on UserNotFound {
      _currentState = UserState.notUserRegistered();
    } catch (e) {
      _currentState = UserState.failure(e as Exception);
    }
    notifyListeners();
  }
}
