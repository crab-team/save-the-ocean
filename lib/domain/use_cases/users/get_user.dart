import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class GetUser {
  final UsersRepository _userRepository;

  GetUser(this._userRepository);

  Future<User> call() async {
    return await _userRepository.getUser();
  }
}
