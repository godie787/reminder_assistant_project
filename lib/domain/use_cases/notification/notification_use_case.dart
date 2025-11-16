import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/repositories/notification_repository.dart';

class NotificationUseCase {
  final NotificationRepository notificationRepository;

  NotificationUseCase({required this.notificationRepository});

  Future<void> scheduleReminder(Reminder reminder) async {
    print(
        "Programando notificación para: ${reminder.title} a las ${reminder.dateTime}");

    await notificationRepository.scheduleReminder(reminder);
    print("Notificación programada");
  }

  Future<void> cancelReminder(int id) {
    return notificationRepository.cancelReminder(id);
  }

  Future<void> cancelAll() {
    return notificationRepository.cancelAll();
  }
}
