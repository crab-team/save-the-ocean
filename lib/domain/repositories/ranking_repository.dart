import 'package:save_the_ocean/domain/entities/user.dart';

abstract class RankingRepository {
  Future<List<User>> getRanking();
  Future<void> setScore(String username, int score);
}
