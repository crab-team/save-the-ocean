import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class GetUserByUsername {
  final UsersRepository _userRepository;

  GetUserByUsername(this._userRepository);

  Future<User> call(String username) async {
    return await _userRepository.getUserByUsername(username);
  }
}
