import 'package:save_the_ocean/domain/entities/user.dart';

abstract class UsersRepository {
  Future<User> getUser();
  Future<User> getUserByUsername(String username);
  Future<User> getLocalUser();
  Future<User> updateUserScore(String username, double score);
  Future<User> createUser(User user);
}
