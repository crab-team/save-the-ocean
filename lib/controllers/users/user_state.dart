import 'package:save_the_ocean/domain/entities/user.dart';

enum UserStatus { initial, loading, noUsernameLocally, userNotFound, userAlreadyExists, success, failure }

class UserState {
  final UserStatus status;
  final Exception? error;
  final User? user;

  UserState({required this.status, this.error, this.user});

  factory UserState.initial() {
    return UserState(status: UserStatus.initial);
  }

  factory UserState.loading() {
    return UserState(status: UserStatus.loading);
  }

  factory UserState.notUserRegistered() {
    return UserState(status: UserStatus.userNotFound);
  }

  factory UserState.notUsernameLocally() {
    return UserState(status: UserStatus.noUsernameLocally);
  }

  factory UserState.userAlreadyExists() {
    return UserState(status: UserStatus.userAlreadyExists);
  }

  factory UserState.success(User user) {
    return UserState(status: UserStatus.success, user: user);
  }

  factory UserState.failure(Exception error) {
    return UserState(status: UserStatus.failure, error: error);
  }
}
