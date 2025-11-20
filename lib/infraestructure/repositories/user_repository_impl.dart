import 'package:reminder_assistant/domain/entities/user/user.dart';
import 'package:reminder_assistant/domain/repositories/user_repository.dart';
import 'package:reminder_assistant/infraestructure/datasources/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;

  UserRepositoryImpl({required this.userDatasource});

  @override
  Future<User?> getUserId(String id) async {
    final user = await userDatasource.getCurrentUser();
    return user;
  }

  @override
  Future<User> createUser(User user) async {
    return await userDatasource.createUser(user);
  }
}
