import 'package:flutter/material.dart';
import 'package:reminder_assistant/data/local_reminders.dart';
import 'package:reminder_assistant/domain/models/reminder.dart';

class ReminderProvider extends ChangeNotifier {
  bool initialLoading = true;
  List<Reminder> reminders = [];

  Future<void> fetchReminders() async {
    await Future.delayed(const Duration(seconds: 2));

    reminders = localReminders.map((json) => Reminder.fromJson(json)).toList();

    initialLoading = false;
    notifyListeners();
  }
}
