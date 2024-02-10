import 'package:flutter/material.dart';
import 'package:save_the_ocean/data/repository_provider.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';
import 'package:save_the_ocean/domain/use_cases/users/update_user.dart';

class ScoreNotifier with ChangeNotifier {
  double _score = 0;

  double get score => _score;

  Future<void> updateScore(double newScore) async {
    int newScoreInt = (newScore * 1000).toInt();

    UsersRepository usersRepository = RepositoryProvider.provideUsers();
    final updateUser = UpdateUserScore(usersRepository);
    updateUser.call(newScoreInt);
    notifyListeners();
  }

  void restart() {
    _score = 0;
    notifyListeners();
  }
}
