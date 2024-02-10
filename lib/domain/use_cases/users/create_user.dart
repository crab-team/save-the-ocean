import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class CreateUser {
  final UsersRepository _userRepository;

  CreateUser(this._userRepository);

  Future<User> call(String username) async {
    final user = User(username: username, score: 0);
    return await _userRepository.createUser(user);
  }
}
