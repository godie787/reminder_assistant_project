import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/repositories/notification_repository.dart';
import 'package:reminder_assistant/infraestructure/notifications/local_notifications_service.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final LocalNotificationsService notificationsService;

  NotificationRepositoryImpl({required this.notificationsService});

  @override
  Future<void> scheduleReminder(Reminder reminder) async {
    if (reminder.status.toLowerCase() == 'completado') return;

    await notificationsService.scheduleReminderNotification(
      id: reminder.id,
      title: reminder.title,
      body: reminder.description,
      dateTime: reminder.dateTime,
    );
  }

  @override
  Future<void> cancelReminder(int id) async {
    await notificationsService.cancelReminderNotification(id);
  }

  @override
  Future<void> cancelAll() async {
    await notificationsService.cancelAll();
  }
}
