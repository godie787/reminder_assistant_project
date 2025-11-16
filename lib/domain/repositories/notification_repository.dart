import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';

abstract class NotificationRepository {
  Future<void> scheduleReminder(Reminder reminder);
  Future<void> cancelReminder(int id);
  Future<void> cancelAll();
}
