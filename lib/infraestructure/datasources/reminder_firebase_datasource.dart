import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';

class ReminderFirebaseDataSource {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String dbCollection = 'reminders';

  String? get currentUserId => fb_auth.FirebaseAuth.instance.currentUser?.uid;

  Future<List<Map<String, dynamic>>> getAll() async {
    try {
      if (currentUserId == null) {
        print('Warning: No authenticated user, returning empty list');
        return [];
      }

      final snapshot = await db
          .collection(dbCollection)
          .where('userId', isEqualTo: currentUserId)
          .get();

      print('Found ${snapshot.docs.length} reminders for user: $currentUserId');

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
          'userId': data['userId'] ?? '',
        };
      }).toList();
    } catch (e) {
      print("Error in getAll: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getById(int id) async {
    if (currentUserId == null) {
      throw Exception('No authenticated user');
    }

    final snapshot = await db
        .collection(dbCollection)
        .where('id', isEqualTo: id)
        .where('userId', isEqualTo: currentUserId)
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
      'userId': data['userId'] ?? '',
    };
  }

  Future<void> deleteById(int id) async {
    if (currentUserId == null) {
      throw Exception('No authenticated user');
    }

    final snapshot = await db
        .collection(dbCollection)
        .where('id', isEqualTo: id)
        .where('userId', isEqualTo: currentUserId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return;

    await snapshot.docs.first.reference.delete();
  }

  Future<Reminder> create(Reminder reminder) async {
    if (currentUserId == null) {
      throw Exception('No authenticated user');
    }

    final userReminders = await db
        .collection(dbCollection)
        .where('userId', isEqualTo: currentUserId)
        .get();

    int nextId = 1;
    if (userReminders.docs.isNotEmpty) {
      final ids = userReminders.docs
          .map((doc) => doc.data()['id'] as int? ?? 0)
          .toList();
      nextId = (ids.reduce((a, b) => a > b ? a : b)) + 1;
    }

    final data = {
      'id': nextId,
      'title': reminder.title,
      'description': reminder.description,
      'dateTime': reminder.dateTime.toIso8601String(),
      'frequency': reminder.frequency,
      'status': reminder.status,
      'selectedDays': reminder.selectedDays,
      'userId': currentUserId,
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
      userId: currentUserId!,
    );
  }

  Future<Map<String, dynamic>> update(Reminder reminder) async {
    if (currentUserId == null) {
      throw Exception('No authenticated user');
    }

    final snapshot = await db
        .collection(dbCollection)
        .where('id', isEqualTo: reminder.id)
        .where('userId', isEqualTo: currentUserId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('Reminder with id ${reminder.id} not found for current user');
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
      'userId': currentUserId,
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
      'userId': currentUserId!,
    };
  }
}
