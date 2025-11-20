import 'package:reminder_assistant/domain/entities/user/user.dart';
import 'package:reminder_assistant/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase({required this.userRepository});

  Future<User?> getUser() async {
    return await userRepository.getUserId('');
  }

  Future<User> createUser(User user) async {
    return await userRepository.createUser(user);
  }
}
