import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';
import 'package:save_the_ocean/domain/user.dart';

class InMemoryRankingRepository implements RankingRepository {
  @override
  Future<List<User>> getRanking() {
    final List<User> users = [
      User(username: 'josesito87', time: DateTime(1990, 11, 13, 1, 2, 10, 32).millisecondsSinceEpoch),
      User(username: 'josesito87', time: DateTime(1990, 11, 13, 0, 5, 10, 765).millisecondsSinceEpoch),
      User(username: 'josesito87', time: DateTime(1990, 11, 13, 0, 7, 10, 247).millisecondsSinceEpoch),
      User(username: 'josesito87', time: DateTime(1990, 11, 13, 0, 57, 10, 451).millisecondsSinceEpoch),
      User(username: 'josesito87', time: DateTime(1990, 11, 13, 0, 61, 10, 987).millisecondsSinceEpoch),
    ];

    return Future.delayed(
      const Duration(seconds: 2),
      () => users,
    );
  }
}