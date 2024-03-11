import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';
import 'package:save_the_ocean/domain/entities/user.dart';

class FirestoreRankingRepository implements RankingRepository {
  final FirebaseFirestore firestore;

  FirestoreRankingRepository({required this.firestore});

  @override
  Future<List<User>> getRanking() async {
    QuerySnapshot snapshot = await _usersCollection().get();

    List<User> users = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return User.fromMap(data);
    }).toList();

    users.sort((a, b) => b.score.compareTo(a.score));

    return users;
  }

  @override
  Future<void> setScore(String username, int score) async {
    await _usersCollection().doc(username).set({'username': username, 'score': score}, SetOptions(merge: true));
  }

  CollectionReference _usersCollection() {
    return firestore.collection('users');
  }
}
