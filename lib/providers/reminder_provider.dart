import 'package:flutter/material.dart';
import 'package:reminder_assistant/constants/frecuencies.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderUseCase reminderUseCase;

  ReminderProvider({required this.reminderUseCase});

  bool initialLoading = true;
  List<Reminder> reminders = [];
  List<String> selectedDays = [];

  bool isEditing = false;
  bool isDeleting = false;
  bool isAdding = false;
  bool isViewing = false;

  String frecuency = Frecuencies.unique;
  DateTime selectedTime = DateTime.now();
  String amPm = DateTime.now().hour >= 12 ? 'PM' : 'AM';
  String title = '';
  String description = '';
  bool isTitleValid = true;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void setTitle(String value) {
    title = value;
    isTitleValid = value.length <= 21;
    notifyListeners();
  }

  void setDescription(String value) {
    description = value;
    notifyListeners();
  }

  void handleDaySelection(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    notifyListeners();
  }

  void setIsViewing(bool viewing) {
    isViewing = viewing;
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

  void resetReminderForm() {
    titleController.clear();
    descriptionController.clear();
    title = '';
    description = '';
    frecuency = Frecuencies.unique;
    selectedTime = DateTime.now();
    amPm = selectedTime.hour >= 12 ? 'PM' : 'AM';
    selectedDays.clear();
    notifyListeners();
  }

  void resetAllStates() {
    isAdding = false;
    isEditing = false;
    isDeleting = false;
    isViewing = false;
    notifyListeners();
  }

  Future<void> fetchReminders() async {
    initialLoading = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 500));
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
    resetReminderForm();
  }

  Future<void> loadReminderData(int id) async {
    final reminder = await reminderUseCase.getReminderById(id);

    titleController.text = reminder.title;
    descriptionController.text = reminder.description;
    title = reminder.title;
    description = reminder.description;
    frecuency = reminder.frequency;
    selectedTime = reminder.dateTime;
    amPm = selectedTime.hour >= 12 ? 'PM' : 'AM';
    selectedDays = [...reminder.selectedDays];
    notifyListeners();
  }

  Future<Reminder> editReminder(Reminder reminder) async {
    final editedReminder = await reminderUseCase.updateReminder(reminder);
    await fetchReminders();
    resetReminderForm();
    return editedReminder;
  }
}
