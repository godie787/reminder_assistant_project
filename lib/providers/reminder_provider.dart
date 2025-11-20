import 'package:flutter/material.dart';
import 'package:reminder_assistant/constants/frecuencies.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';
import 'package:reminder_assistant/infraestructure/notifications/local_notifications_service.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderUseCase reminderUseCase;
  ReminderProvider({required this.reminderUseCase});

  bool initialLoading = true;
  List<Reminder> reminders = [];
  List<String> selectedDays = [];

  bool isEditing = false;
  bool isDeleting = false;
  bool isAdding = false;
  bool isReading = false;
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

  void setIsReading(bool reading) {
    isReading = reading;
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
    selectedTime = DateTime(
      selectedTime.year,
      selectedTime.month,
      selectedTime.day,
      time.hour,
      time.minute,
    );
    amPm = time.hour >= 12 ? 'PM' : 'AM';
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    selectedTime = DateTime(
      date.year,
      date.month,
      date.day,
      selectedTime.hour,
      selectedTime.minute,
    );

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
    isReading = false;
    notifyListeners();
  }

  void clearReminders() {
    reminders = [];
    notifyListeners();
  }

  Future<void> fetchReminders() async {
    initialLoading = true;
    notifyListeners();
    try {
      reminders = await reminderUseCase.getAllReminders();
    } catch (e, s) {
      print("ERROR en fetchReminders: $e");
    }

    initialLoading = false;
    notifyListeners();
  }

  Future<void> deleteReminder(int id) async {
    await LocalNotificationsService().cancelAllNotifications();

    await reminderUseCase.deleteReminder(id);
    await fetchReminders();
  }

  Future<void> addReminder(Reminder reminder) async {
    if (reminder.frequency == 'semanal' && reminder.selectedDays.isNotEmpty) {
      for (String day in reminder.selectedDays) {
        await LocalNotificationsService().scheduleNotification(
          id: reminder.id,
          title: reminder.title,
          body: reminder.description,
          year: reminder.dateTime.year,
          month: reminder.dateTime.month,
          day: reminder.dateTime.day,
          hour: reminder.dateTime.hour,
          minute: reminder.dateTime.minute,
          selectedDays: reminder.selectedDays,
        );
        print("selected days: ${reminder.selectedDays}");
      }
    } else {
      await LocalNotificationsService().scheduleNotification(
        id: reminder.id,
        title: reminder.title,
        body: reminder.description,
        year: reminder.dateTime.year,
        month: reminder.dateTime.month,
        day: reminder.dateTime.day,
        hour: reminder.dateTime.hour,
        minute: reminder.dateTime.minute,
      );
    }

    if (reminder.id != 0) {
      await reminderUseCase.updateReminder(reminder);
      print("Recordatorio actualizado");
    } else {
      await reminderUseCase.createReminder(reminder);
      print("Nuevo recordatorio creado");
    }

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
    await LocalNotificationsService().cancelAllNotifications();

    await reminderUseCase.updateReminder(reminder);
    await addReminder(reminder);

    await fetchReminders();
    resetReminderForm();
    return reminder;
  }
}
