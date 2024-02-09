import 'package:flutter/material.dart';
import 'package:save_the_ocean/data/repository_provider.dart';
import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';
import 'package:save_the_ocean/domain/use_cases/ranking/update_score.dart';

class ScoreNotifier with ChangeNotifier {
  double _score = 0;

  double get score => _score;

  void updateScore(double newScore) {
    int newScoreInt = (newScore * 1000).toInt();

    RankingRepository rankingRepository = RepositoryProvider.provideRanking();
    final updateScoreUseCase = UpdateScore(rankingRepository);
    updateScoreUseCase.call("maurinho", newScoreInt);
    notifyListeners();
  }

  void restart() {
    _score = 0;
    notifyListeners();
  }
}
