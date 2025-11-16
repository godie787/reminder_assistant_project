import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/repositories/reminder_repository.dart';
import 'package:reminder_assistant/infraestructure/datasources/reminder_firebase_datasource.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderFirebaseDataSource reminderDataSource;

  ReminderRepositoryImpl(this.reminderDataSource);

  @override
  Future<List<Reminder>> getAllReminders() async {
    final reminders = await reminderDataSource.getAll();
    return reminders.map((json) {
      return Reminder(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        dateTime: DateTime.parse(json['dateTime']),
        frequency: json['frequency'],
        status: json['status'],
        selectedDays: (json['selectedDays'] as String?)?.split(',') ?? [],
      );
    }).toList();
  }

  @override
  Future<Reminder> getReminderById(int id) async {
    final reminder = await reminderDataSource.getById(id);
    if (reminder == null) {
      throw Exception('Reminder with id $id not found');
    }
    return Reminder(
      id: reminder['id'],
      title: reminder['title'],
      description: reminder['description'],
      dateTime: DateTime.parse(reminder['dateTime']),
      frequency: reminder['frequency'],
      status: reminder['status'],
      selectedDays: (reminder['selectedDays'] as String?)?.split(',') ?? [],
    );
  }

  @override
  Future<Reminder> createReminder(Reminder reminder) {
    return reminderDataSource.create(reminder);
  }

  @override
  Future<Reminder> updateReminder(Reminder reminder) async {
    final updatedJson = await reminderDataSource.update(reminder);

    return Reminder(
      id: updatedJson['id'],
      title: updatedJson['title'],
      description: updatedJson['description'],
      dateTime: DateTime.parse(updatedJson['dateTime']),
      frequency: updatedJson['frequency'],
      status: updatedJson['status'],
      selectedDays: (updatedJson['selectedDays'] as String?)?.split(',') ?? [],
    );
  }

  @override
  Future<void> deleteReminder(int id) async {
    final reminderExists = await reminderDataSource.getById(id);
    if (reminderExists == null) {
      throw Exception('Reminder with id $id not found');
    }
    await reminderDataSource.deleteById(id);
  }
}
