import 'package:flutter/material.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderUseCase reminderUseCase;

  ReminderProvider({required this.reminderUseCase});

  bool initialLoading = true;
  List<Reminder> reminders = [];

  bool isEditing = false;
  bool isDeleting = false;

  void setIsEditing(bool editing) {
    isEditing = editing;
    notifyListeners();
  }

  void setIsDeleting(bool deleting) {
    isDeleting = deleting;
    notifyListeners();
  }

  Future<void> fetchReminders() async {
    initialLoading = true;
    notifyListeners();

    reminders = await reminderUseCase.getAllReminders();

    initialLoading = false;
    notifyListeners();
  }

  Future<void> deleteReminder(int id) async {
    await reminderUseCase.deleteReminder(id);
    await fetchReminders();
  }
}
