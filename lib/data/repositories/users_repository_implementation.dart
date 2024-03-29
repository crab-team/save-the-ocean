import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_the_ocean/controllers/users/user_error.dart';
import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';
import 'package:save_the_ocean/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImplementation implements UsersRepository {
  final FirebaseFirestore _firestore;
  final SharedPreferences _sharedPreferences;

  UserRepositoryImplementation({required FirebaseFirestore firestore, required SharedPreferences sharedPreferences})
      : _firestore = firestore,
        _sharedPreferences = sharedPreferences;

  @override
  Future<User> createUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.username).set(user.toMap());
      Logger.log('User created ${user.toMap()}');
      await createUserLocally(user);
      return user;
    } catch (e) {
      Logger.error('Error creating user: $e');
      rethrow;
    }
  }

  Future<void> createUserLocally(User user) async {
    try {
      Logger.log('Creating user locally');
      _sharedPreferences.setString('user', json.encode(user.toMap()));
    } catch (ex) {
      Logger.error('Error creating user locally: $ex');
      rethrow;
    }
  }

  @override
  Future<User?> getUserByUsername(String username) async {
    try {
      Logger.log('Getting user by username');
      final user = await _firestore.collection('users').where('username', isEqualTo: username).get();
      if (user.docs.isNotEmpty) {
        Logger.log('User: ${user.docs.first.data()}');
        return User.fromMap(user.docs.first.data());
      }

      return null;
    } catch (e) {
      Logger.error('Error getting user by username: $e');
      rethrow;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      Logger.log('Getting user');
      User currentUser = await getLocalUser();
      final user = await _firestore.collection('users').doc(currentUser.username).get();
      if (user.exists) {
        Logger.log('User: ${user.data()}');
        return User.fromMap(user.data()!);
      }

      return null;
    } catch (e) {
      Logger.error('Error getting user: $e');
      rethrow;
    }
  }

  @override
  Future<User> updateUserScore(String username, double newScore) async {
    try {
      Logger.log('Updating user score');
      await _firestore.collection('users').doc(username).set({'score': newScore}, SetOptions(merge: true));
      await updateUserScoreLocally(newScore);
      return User(username: username, score: newScore);
    } catch (e) {
      Logger.error('Error updating user score: $e');
      rethrow;
    }
  }

  Future<void> updateUserScoreLocally(double newScore) async {
    Logger.log('Updating user score locally');
    User currentUser = await getLocalUser();
    User updatedUser = User(score: newScore, username: currentUser.username);
    _sharedPreferences.setString('user', json.encode(updatedUser.toMap()));
  }

  @override
  Future<User> getLocalUser() async {
    try {
      Logger.log('Getting local user');
      String? user = _sharedPreferences.getString('user');
      if (user == null) {
        Logger.error('No user locally');
        throw NoUsernameLocally();
      }

      Map<String, dynamic> jsonUser = jsonDecode(user);
      User localUser = User.fromMap(jsonUser);
      Logger.log('Local user: ${localUser.toMap()}');
      return localUser;
    } catch (e) {
      Logger.error('Error getting local user: $e');
      rethrow;
    }
  }

  @override
  Future<bool> isFirstTime() async {
    try {
      return _sharedPreferences.getBool('firstTime') ?? true;
    } catch (ex) {
      Logger.error('Error getting first time: $ex');
      rethrow;
    }
  }

  @override
  Future<void> saveFirstTime() async {
    try {
      await _sharedPreferences.setBool('firstTime', false);
    } catch (ex) {
      Logger.error('Error saving first time: $ex');
      rethrow;
    }
  }
}
