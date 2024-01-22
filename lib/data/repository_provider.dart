import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_the_ocean/data/repositories/firestore_ranking_repository.dart';
import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';

class RepositoryProvider {
  static RankingRepository? _rankingRepository;

  static RankingRepository provideRanking() {
    return _rankingRepository ??= FirestoreRankingRepository(firestore: _provideFirestore());
  }

  static _provideFirestore() {
    return FirebaseFirestore.instance;
  }
}
