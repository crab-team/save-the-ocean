import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class UpdateUserScore {
  final UsersRepository _userRepository;

  UpdateUserScore(this._userRepository);

  Future<User> call(int score) async {
    return await _userRepository.updateUserScore(score);
  }
}
