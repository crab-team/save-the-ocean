enum UserStatus { initial, loading, noUsernameLocally, userNotFound, userAlreadyExists, success, failure }

class UserControllerState {
  final UserStatus status;
  final Exception? error;

  UserControllerState({required this.status, this.error});

  factory UserControllerState.initial() {
    return UserControllerState(status: UserStatus.initial);
  }

  factory UserControllerState.loading() {
    return UserControllerState(status: UserStatus.loading);
  }

  factory UserControllerState.notUserRegistered() {
    return UserControllerState(status: UserStatus.userNotFound);
  }

  factory UserControllerState.notUsernameLocally() {
    return UserControllerState(status: UserStatus.noUsernameLocally);
  }

  factory UserControllerState.userAlreadyExists() {
    return UserControllerState(status: UserStatus.userAlreadyExists);
  }

  factory UserControllerState.success() {
    return UserControllerState(status: UserStatus.success);
  }

  factory UserControllerState.failure(Exception error) {
    return UserControllerState(status: UserStatus.failure, error: error);
  }
}
