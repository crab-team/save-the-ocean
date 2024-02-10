import 'package:save_the_ocean/domain/entities/user.dart';

abstract class UsersRepository {
  Future<User> getUser();
  Future<User> getUserByUsername(String username);
  Future<String> getLocalUsername();
  Future<User> updateUserScore(int score);
  Future<User> createUser(User user);
}
