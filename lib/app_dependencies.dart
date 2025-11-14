import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';
import 'package:reminder_assistant/infraestructure/datasources/reminder_local_datasource.dart';
import 'package:reminder_assistant/infraestructure/repositories/reminder_repository_impl.dart';

class AppDependencies {
  late final ReminderLocalDataSource reminderLocalDataSource;
  late final ReminderRepositoryImpl reminderRepository;
  late final ReminderUseCase reminderUseCase;

  AppDependencies() {
    reminderLocalDataSource = ReminderLocalDataSource();
    reminderRepository = ReminderRepositoryImpl(reminderLocalDataSource);
    reminderUseCase = ReminderUseCase(reminderRepository: reminderRepository);
  }
}
