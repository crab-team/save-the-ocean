import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class GetLocalUser {
  final UsersRepository _usersRepository;

  GetLocalUser(this._usersRepository);

  Future<User> call() async {
    return await _usersRepository.getLocalUser();
  }
}
