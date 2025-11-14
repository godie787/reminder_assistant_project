class ReminderLocalDataSource {
  final List<Map<String, dynamic>> _localReminders = [
    {
      'id': 1,
      'title': 'Reminder 1',
      'description': 'Description 1',
      'dateTime': '2025-11-11T10:00:00Z',
      'frequency': 'Diario',
      'status': 'Pendiente'
    },
    {
      'id': 2,
      'title': 'Reminder 2',
      'description': 'Description 2',
      'dateTime': '2025-12-12T12:00:00Z',
      'frequency': 'Semanal',
      'status': 'Completado'
    },
    {
      'id': 3,
      'title': 'Reminder 3',
      'description': 'Description 3',
      'dateTime': '2026-01-01T09:00:00Z',
      'frequency': 'Mensual',
      'status': 'Pendiente'
    }
  ];

  Future<List<Map<String, dynamic>>> getAll() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _localReminders;
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    return _localReminders.firstWhere(
      (e) => e['id'].toString() == id,
      orElse: () => {},
    );
  }
}
