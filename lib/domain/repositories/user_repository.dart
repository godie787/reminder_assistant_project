import 'package:reminder_assistant/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<User?> getUserId(String id);
  Future<User> createUser(User user);
}
