class UserAlreadyExists implements Exception {}

class UserNotFound implements Exception {}

class NoUsernameLocally implements Exception {}

class UserError implements Exception {
  final String message;

  UserError(this.message);
}
