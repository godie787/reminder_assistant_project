import 'package:flutter/material.dart';
import 'package:reminder_assistant/constants/frecuencies.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderUseCase reminderUseCase;

  ReminderProvider({required this.reminderUseCase});

  bool initialLoading = true;
  List<Reminder> reminders = [];
  List<String> selectedDays = ['Lunes'];

  bool isEditing = false;
  bool isDeleting = false;
  bool isAdding = false;
  String frecuency = Frecuencies.unique;
  DateTime selectedTime = DateTime.now();
  String amPm = DateTime.now().hour >= 12 ? 'PM' : 'AM';

  void handleDaySelection(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    notifyListeners();
  }

  void setIsAdding(bool adding) {
    isAdding = adding;
    notifyListeners();
  }

  void setIsEditing(bool editing) {
    isEditing = editing;
    notifyListeners();
  }

  void setIsDeleting(bool deleting) {
    isDeleting = deleting;
    notifyListeners();
  }

  void setFrecuency(String value) {
    frecuency = value;
    notifyListeners();
  }

  void setSelectedHour(DateTime time) {
    selectedTime = time;
    amPm = time.hour >= 12 ? 'PM' : 'AM';
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

  Future<void> addReminder(Reminder reminder) async {
    await reminderUseCase.createReminder(reminder);
    await fetchReminders();
  }
}
