import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class GetUserId {
  final UsersRepository _userRepository;

  GetUserId(this._userRepository);

  Future<String> call() async {
    return await _userRepository.getLocalUsername();
  }
}
