import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_the_ocean/data/repositories/firestore_ranking_repository.dart';
import 'package:save_the_ocean/data/repositories/users_repository_implementation.dart';
import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';

class RepositoryProvider {
  static RankingRepository? _rankingRepository;
  static UsersRepository? _usersRepository;

  static RankingRepository provideRanking() {
    return _rankingRepository ??= FirestoreRankingRepository(firestore: _provideFirestore());
  }

  static UsersRepository provideUsers() {
    return _usersRepository ??= UserRepositoryImplementation(firestore: _provideFirestore());
  }

  static _provideFirestore() {
    return FirebaseFirestore.instance;
  }
}
