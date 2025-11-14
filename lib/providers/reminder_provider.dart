import 'package:flutter/material.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderUseCase reminderUseCase;

  ReminderProvider({required this.reminderUseCase});

  bool initialLoading = true;
  List<Reminder> reminders = [];

  Future<void> fetchReminders() async {
    initialLoading = true;
    notifyListeners();

    reminders = await reminderUseCase.getAllReminders();

    initialLoading = false;
    notifyListeners();
  }
}
