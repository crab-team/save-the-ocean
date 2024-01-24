import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';

class UpdateScore {
  final RankingRepository _rankingRepository;

  UpdateScore(this._rankingRepository);

  Future<void> call(String username, int score) async {
    return await _rankingRepository.setScore(username, score);
  }
}
