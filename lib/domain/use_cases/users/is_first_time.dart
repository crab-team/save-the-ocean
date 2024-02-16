import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class IsFirstTime {
  final UsersRepository _repository;

  IsFirstTime(this._repository);

  Future<bool> call() async {
    return await _repository.isFirstTime();
  }
}
