import 'package:flutter/material.dart';
import 'package:save_the_ocean/controllers/users/user_error.dart';
import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/use_cases/users/create_user.dart';
import 'package:save_the_ocean/domain/use_cases/users/get_user.dart';
import 'package:save_the_ocean/domain/use_cases/users/get_user_by_username.dart';
import 'package:save_the_ocean/domain/use_cases/users/is_first_time.dart';
import 'package:save_the_ocean/domain/use_cases/users/save_first_time.dart';
import 'package:save_the_ocean/domain/use_cases/users/update_user.dart';

enum UserControllerState { initial, loading, notUserRegistered, notUsernameLocally, failure, success }

class UserController extends ChangeNotifier {
  final GetUser getUserUseCase;
  final GetUserByUsername getUserByUsername;
  final CreateUser createUserUseCase;
  final UpdateUserScore updateUserScoreUseCase;
  final IsFirstTime isFirstTimeUseCase;
  final SaveFirstTime saveFirstTimeUseCase;

  UserController(
      {required this.getUserUseCase,
      required this.createUserUseCase,
      required this.updateUserScoreUseCase,
      required this.getUserByUsername,
      required this.isFirstTimeUseCase,
      required this.saveFirstTimeUseCase});

  bool _isFirstTime = true;
  bool get isFirstTime => _isFirstTime;
  UserControllerState _currentState = UserControllerState.initial;
  UserControllerState get currentState => _currentState;
  User? _user;
  User? get currentUser => _user;

  set currentUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<User?> fetchByUsername(String username) async {
    loading();
    try {
      final User? user = await getUserByUsername.call(username);
      if (user == null) {
        notUserRegistered();
        return null;
      }

      success(user);
      return user;
    } catch (e) {
      failure(e as Exception);
    }
    return null;
  }

  Future<User?> fetch() async {
    loading();
    try {
      final User? user = await getUserUseCase.call();
      if (user == null) {
        notUserRegistered();
        return null;
      }

      success(user);
      return user;
    } catch (e) {
      failure(e as Exception);
    }
    return null;
  }

  Future<void> create(String username) async {
    try {
      User user = await createUserUseCase.call(username);
      success(user);
    } catch (e) {
      failure(e as Exception);
    }
  }

  Future<void> updateScore(double newScore) async {
    loading();
    try {
      if (currentUser == null) return skip();
      if (currentUser!.score > newScore) return skip();
      User user = await updateUserScoreUseCase.call(currentUser!.username, newScore);
      success(user);
    } on UserNotFound {
      notUserRegistered();
      rethrow;
    } catch (e) {
      failure(e as Exception);
    }
  }

  Future<void> checkFirstTime() async {
    _isFirstTime = await isFirstTimeUseCase.call();
    notifyListeners();
  }

  void saveFirstTime() async {
    await saveFirstTimeUseCase.call();
    _isFirstTime = false;
    notifyListeners();
  }

  loading() {
    _currentState = UserControllerState.loading;
    notifyListeners();
  }

  notUserRegistered() {
    _currentState = UserControllerState.notUserRegistered;
    notifyListeners();
  }

  notUsernameLocally() {
    _currentState = UserControllerState.notUsernameLocally;
    notifyListeners();
  }

  failure(Exception e) {
    _currentState = UserControllerState.failure;
    notifyListeners();
  }

  skip() {
    _currentState = UserControllerState.success;
    notifyListeners();
  }

  success(User user) {
    _currentState = UserControllerState.success;
    currentUser = user;
    notifyListeners();
  }
}
