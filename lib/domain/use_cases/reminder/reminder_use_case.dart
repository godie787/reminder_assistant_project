import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/repositories/reminder_repository.dart';

class ReminderUseCase {
  final ReminderRepository reminderRepository;

  ReminderUseCase({required this.reminderRepository});

  Future<Reminder> getReminderById(int id) {
    return reminderRepository.getReminderById(id);
  }

  Future<List<Reminder>> getAllReminders() {
    return reminderRepository.getAllReminders();
  }

  Future<Reminder> createReminder(Reminder reminder) {
    return reminderRepository.createReminder(reminder);
  }

  Future<Reminder> updateReminder(Reminder reminder) {
    return reminderRepository.updateReminder(reminder);
  }

  Future<void> deleteReminder(int id) {
    return reminderRepository.deleteReminder(id);
  }
}
