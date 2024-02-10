import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_the_ocean/controllers/users/user_error.dart';
import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImplementation implements UsersRepository {
  final FirebaseFirestore _firestore;

  UserRepositoryImplementation({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<User> createUser(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? currentUser = sharedPreferences.getString('username');
    if (currentUser == user.username) {
      return getUser();
    }

    sharedPreferences.setString('username', user.username);
    await _firestore.collection('users').doc(user.username).set(user.toMap());
    return user;
  }

  @override
  Future<User> getUserByUsername(String username) async {
    final user = await _firestore.collection('users').where('username', isEqualTo: username).get();
    if (user.docs.isNotEmpty) {
      return User.fromMap(user.docs.first.data());
    } else {
      throw UserNotFound();
    }
  }

  @override
  Future<User> getUser() async {
    String currentUsername = await getLocalUsername();
    final user = await _firestore.collection('users').doc(currentUsername).get();
    if (user.exists) {
      return User.fromMap(user.data()!);
    } else {
      throw UserNotFound();
    }
  }

  @override
  Future<User> updateUserScore(int newScore) async {
    String currentUsername = await getLocalUsername();
    await _firestore.collection('users').doc(currentUsername).set({'score': newScore}, SetOptions(merge: true));
    return getUser();
  }

  @override
  Future<String> getLocalUsername() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? currentUsername = sharedPreferences.getString('username');
    print('currentUser: $currentUsername');
    if (currentUsername == null) {
      throw NoUsernameLocally();
    }
    return currentUsername;
  }
}
