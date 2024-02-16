import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class SaveFirstTime {
  final UsersRepository _repository;

  SaveFirstTime(this._repository);

  Future<void> call() async {
    await _repository.saveFirstTime();
  }
}
