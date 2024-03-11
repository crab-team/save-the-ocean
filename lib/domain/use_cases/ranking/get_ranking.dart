import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';
import 'package:save_the_ocean/domain/entities/user.dart';

class GetRanking {
  final RankingRepository _rankingRepository;

  GetRanking(this._rankingRepository);

  Future<List<User>> call() async {
    return await _rankingRepository.getRanking();
  }
}
