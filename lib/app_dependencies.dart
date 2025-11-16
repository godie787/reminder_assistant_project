import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';
import 'package:reminder_assistant/domain/use_cases/user/user_use_case.dart';
import 'package:reminder_assistant/infraestructure/datasources/reminder_local_datasource.dart';
import 'package:reminder_assistant/infraestructure/datasources/user_datasource.dart';
import 'package:reminder_assistant/infraestructure/repositories/reminder_repository_impl.dart';
import 'package:reminder_assistant/infraestructure/repositories/user_repository_impl.dart';

class ReminderDependencies {
  late final ReminderLocalDataSource reminderLocalDataSource;
  late final ReminderRepositoryImpl reminderRepository;
  late final ReminderUseCase reminderUseCase;

  ReminderDependencies() {
    reminderLocalDataSource = ReminderLocalDataSource();
    reminderRepository = ReminderRepositoryImpl(reminderLocalDataSource);
    reminderUseCase = ReminderUseCase(reminderRepository: reminderRepository);
  }
}

class UserDependencies {
  late final UserDatasource userDatasource;
  late final UserRepositoryImpl userRepository;
  late final UserUseCase userUseCase;

  UserDependencies() {
    userDatasource = UserDatasource();
    userRepository = UserRepositoryImpl(userDatasource: userDatasource);
    userUseCase = UserUseCase(userRepository: userRepository);
  }
}
