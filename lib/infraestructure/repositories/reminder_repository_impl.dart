import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/repositories/reminder_repository.dart';
import '../datasources/reminder_local_datasource.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderLocalDataSource reminderLocalDataSource;

  ReminderRepositoryImpl(this.reminderLocalDataSource);

  @override
  Future<List<Reminder>> getAllReminders() async {
    final reminders = await reminderLocalDataSource.getAll();
    return reminders.map((json) {
      return Reminder(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        dateTime: DateTime.parse(json['dateTime']),
        frequency: json['frequency'],
        status: json['status'],
      );
    }).toList();
  }

  @override
  Future<Reminder> getReminderById(int id) async {
    final reminder = await reminderLocalDataSource.getById(id);
    return Reminder(
      id: reminder!['id'],
      title: reminder['title'],
      description: reminder['description'],
      dateTime: DateTime.parse(reminder['dateTime']),
      frequency: reminder['frequency'],
      status: reminder['status'],
    );
  }

  @override
  Future<Reminder> createReminder(Reminder reminder) {
    throw UnimplementedError();
  }

  @override
  Future<Reminder> updateReminder(Reminder reminder) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteReminder(int id) async {
    final reminderExists = await reminderLocalDataSource.getById(id);
    if (reminderExists == null) {
      throw Exception('Reminder with id $id not found');
    }
    await reminderLocalDataSource.deleteById(id);
  }
}
