import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';

class ReminderLocalDataSource {
  final List<Map<String, dynamic>> _localReminders = [
    {
      'id': 1,
      'title': 'Estirar las piernas',
      'description':
          'Hacer una pausa para estirar las piernas y mejorar la circulación',
      'dateTime': '2025-11-11T22:13:00Z',
      'frequency': 'semanal',
      'status': 'Pendiente',
      'selectedDays': 'Lunes,Miércoles,Viernes'
    },
    {
      'id': 2,
      'title': 'Estirar los brazos',
      'description':
          'Hacer una pausa para estirar los brazos y aliviar la tensión',
      'dateTime': '2025-12-12T12:00:00Z',
      'frequency': 'semanal',
      'status': 'Completado',
      'selectedDays': 'Martes,Jueves'
    },
    {
      'id': 3,
      'title': 'Estirar la espalda',
      'description':
          'Hacer una pausa para estirar la espalda y aliviar la tensión',
      'dateTime': '2026-01-01T09:00:00Z',
      'frequency': 'unico',
      'status': 'Pendiente'
    },
    {
      'id': 4,
      'title': 'Caminar un poco',
      'description':
          'Hacer una pausa para caminar un poco y mejorar la circulación',
      'dateTime': '2026-02-14T15:30:00Z',
      'frequency': 'unico',
      'status': 'Completado'
    },
    {
      'id': 5,
      'title': 'Beber agua',
      'description': 'Hacer una pausa para beber agua y mantenerse hidratado',
      'dateTime': '2026-03-03T08:45:00Z',
      'frequency': 'Diario',
      'status': 'Pendiente'
    },
    {
      'id': 6,
      'title': 'Descansar la vista',
      'description':
          'Hacer una pausa para descansar la vista y reducir la fatiga ocular',
      'dateTime': '2026-04-20T14:15:00Z',
      'frequency': 'Semanal',
      'status': 'Completado'
    },
  ];

  Future<List<Map<String, dynamic>>> getAll() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _localReminders;
  }

  Future<Map<String, dynamic>?> getById(int id) async {
    return _localReminders.firstWhere(
      (e) => e['id'] == id,
      orElse: () => {},
    );
  }

  Future<void> deleteById(int id) async {
    _localReminders.removeWhere((e) => e['id'] == id);
  }

  Future<Reminder> create(Reminder reminder) async {
    final nextId = _localReminders.isEmpty
        ? 1
        : (_localReminders
                .map((e) => e['id'] as int)
                .reduce((a, b) => a > b ? a : b) +
            1);

    final newReminder = {
      'id': nextId,
      'title': reminder.title,
      'description': reminder.description,
      'dateTime': reminder.dateTime.toIso8601String(),
      'frequency': reminder.frequency,
      'status': reminder.status,
      'selectedDays': reminder.selectedDays.join(','),
    };

    _localReminders.add(newReminder);
    return Reminder(
      id: nextId,
      title: reminder.title,
      description: reminder.description,
      dateTime: reminder.dateTime,
      frequency: reminder.frequency,
      status: reminder.status,
      selectedDays: reminder.selectedDays,
    );
  }

  Future<Map<String, dynamic>> update(Reminder reminder) async {
    final index =
        _localReminders.indexWhere((element) => element['id'] == reminder.id);
    if (index == -1) {
      throw Exception('Reminder with id ${reminder.id} not found');
    }

    final updatedReminder = {
      'id': reminder.id,
      'title': reminder.title,
      'description': reminder.description,
      'dateTime': reminder.dateTime.toIso8601String(),
      'frequency': reminder.frequency,
      'status': reminder.status,
      'selectedDays': reminder.selectedDays.join(','),
    };

    _localReminders[index] = updatedReminder;
    return updatedReminder;
  }
}
