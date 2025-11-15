import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';

abstract class ReminderRepository {
  Future<Reminder> getReminderById(int id);

  Future<List<Reminder>> getAllReminders();

  Future<Reminder> createReminder(Reminder reminder);

  Future<Reminder> updateReminder(Reminder reminder);

  Future<void> deleteReminder(int id);
}
