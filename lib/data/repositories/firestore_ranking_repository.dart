import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';
import 'package:save_the_ocean/domain/user.dart';

class FirestoreRankingRepository implements RankingRepository {
  @override
  Future<List<User>> getRanking() {
    throw UnimplementedError();
  }
}
