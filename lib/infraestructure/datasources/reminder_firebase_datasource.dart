import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';

class ReminderFirebaseDataSource {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String dbCollection = 'reminders';

  Future<List<Map<String, dynamic>>> getAll() async {
    try {
      final snapshot = await db.collection(dbCollection).get();

      return snapshot.docs.map((doc) {
        final data = doc.data();

        return {
          'id': data['id'] as int,
          'title': data['title'] ?? '',
          'description': data['description'] ?? '',
          'dateTime': data['dateTime'] as String,
          'frequency': data['frequency'] ?? '',
          'status': data['status'] ?? '',
          'selectedDays':
              (data['selectedDays'] as List<dynamic>?)?.join(',') ?? '',
        };
      }).toList();
    } catch (e, s) {
      print("Error in getAll: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getById(int id) async {
    final snapshot = await db
        .collection(dbCollection)
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    final data = snapshot.docs.first.data();

    return {
      'id': data['id'] as int,
      'title': data['title'] ?? '',
      'description': data['description'] ?? '',
      'dateTime': data['dateTime'] as String,
      'frequency': data['frequency'] ?? '',
      'status': data['status'] ?? '',
      'selectedDays': (data['selectedDays'] as List<dynamic>?)?.join(',') ?? '',
    };
  }

  Future<void> deleteById(int id) async {
    final snapshot = await db
        .collection(dbCollection)
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return;

    await snapshot.docs.first.reference.delete();
  }

  Future<Reminder> create(Reminder reminder) async {
    final lastSnapshot = await db
        .collection(dbCollection)
        .orderBy('id', descending: true)
        .limit(1)
        .get();

    final nextId = lastSnapshot.docs.isEmpty
        ? 1
        : (lastSnapshot.docs.first.data()['id'] as int) + 1;

    final data = {
      'id': nextId,
      'title': reminder.title,
      'description': reminder.description,
      'dateTime': reminder.dateTime.toIso8601String(),
      'frequency': reminder.frequency,
      'status': reminder.status,
      'selectedDays': reminder.selectedDays,
    };

    await db.collection(dbCollection).add(data);

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
    final snapshot = await db
        .collection(dbCollection)
        .where('id', isEqualTo: reminder.id)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('Reminder with id ${reminder.id} not found');
    }

    final ref = snapshot.docs.first.reference;

    final updatedData = {
      'id': reminder.id,
      'title': reminder.title,
      'description': reminder.description,
      'dateTime': reminder.dateTime.toIso8601String(),
      'frequency': reminder.frequency,
      'status': reminder.status,
      'selectedDays': reminder.selectedDays,
    };

    await ref.update(updatedData);

    return {
      'id': reminder.id,
      'title': reminder.title,
      'description': reminder.description,
      'dateTime': reminder.dateTime.toIso8601String(),
      'frequency': reminder.frequency,
      'status': reminder.status,
      'selectedDays': reminder.selectedDays.join(','),
    };
  }
}
