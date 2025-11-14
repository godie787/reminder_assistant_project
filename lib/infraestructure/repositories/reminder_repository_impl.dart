import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/repositories/reminder_repository.dart';
import '../datasources/reminder_local_datasource.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderLocalDataSource reminderLocalDataSource;

  ReminderRepositoryImpl(this.reminderLocalDataSource);

  @override
  Future<List<Reminder>> getAllReminders() async {
    final list = await reminderLocalDataSource.getAll();
    return list.map((json) {
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
  Future<Reminder> getReminderById(String id) async {
    final json = await reminderLocalDataSource.getById(id);
    return Reminder(
      id: json!['id'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
      frequency: json['frequency'],
      status: json['status'],
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
  Future<Reminder> deleteReminder(String id) {
    throw UnimplementedError();
  }
}
