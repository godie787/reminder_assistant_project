import 'package:reminder_assistant/domain/use_cases/notification/notification_use_case.dart';
import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';
import 'package:reminder_assistant/domain/use_cases/user/user_use_case.dart';
import 'package:reminder_assistant/infraestructure/datasources/user_datasource.dart';
import 'package:reminder_assistant/infraestructure/notifications/local_notifications_service.dart';
import 'package:reminder_assistant/infraestructure/repositories/notification_repository_impl.dart';
import 'package:reminder_assistant/infraestructure/repositories/reminder_repository_impl.dart';
import 'package:reminder_assistant/infraestructure/repositories/user_repository_impl.dart';

import 'package:reminder_assistant/infraestructure/datasources/reminder_firebase_datasource.dart';

class ReminderDependencies {
  late final ReminderFirebaseDataSource reminderDataSource;
  late final ReminderRepositoryImpl reminderRepository;
  late final ReminderUseCase reminderUseCase;

  late final LocalNotificationsService localNotificationsService;
  late final NotificationRepositoryImpl notificationRepository;
  late final NotificationUseCase notificationUseCase;

  ReminderDependencies() {
    reminderDataSource = ReminderFirebaseDataSource();
    reminderRepository = ReminderRepositoryImpl(reminderDataSource);
    reminderUseCase = ReminderUseCase(reminderRepository: reminderRepository);
    
    localNotificationsService = LocalNotificationsService();
    notificationRepository = NotificationRepositoryImpl(
        notificationsService: localNotificationsService);
    notificationUseCase =
        NotificationUseCase(notificationRepository: notificationRepository);
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
