import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_assistant/constants/frecuencies.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/domain/use_cases/notification/notification_use_case.dart';
import 'package:reminder_assistant/domain/use_cases/reminder/reminder_use_case.dart';
import 'package:reminder_assistant/infraestructure/notifications/local_notifications_service.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderUseCase reminderUseCase;
  final NotificationUseCase notificationUseCase;

  ReminderProvider(
      {required this.reminderUseCase, required this.notificationUseCase});

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

  Future<void> fetchReminders() async {
    initialLoading = true;
    notifyListeners();

    await Future.delayed(Duration(milliseconds: 500));
    reminders = await reminderUseCase.getAllReminders();
    // print("Recordatorios cargados: $reminders");

    await notificationUseCase.cancelAll();
    for (final r in reminders) {
      // print("Programando notificación para: ${r.title}");
      await notificationUseCase.scheduleReminder(r);
    }

    initialLoading = false;
    notifyListeners();
  }

  Future<void> deleteReminder(int id) async {
    await reminderUseCase.deleteReminder(id);
    await notificationUseCase.cancelReminder(id);
    await fetchReminders();
  }

  Future<void> addReminder(Reminder reminder) async {
    final created = await reminderUseCase.createReminder(reminder);
    // print("Recordatorio creado: $created");

    await notificationUseCase.scheduleReminder(reminder);

    await LocalNotificationsService().plugin.show(
          0,
          'Prueba de notificación',
          'Notificación de prueba para el recordatorio',
          NotificationDetails(
            android: AndroidNotificationDetails(
              'test_channel',
              'Test Notifications',
              channelDescription: 'Canal de prueba',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );

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

    try {
      // Cancela la notificación existente
      await notificationUseCase.cancelReminder(editedReminder.id);
      // Intenta programar la nueva notificación
      await notificationUseCase.scheduleReminder(editedReminder);
    } catch (e) {
      print("Error al programar la notificación: $e");
    }
    print("Notificación reprogramada para el recordatorio editado.");
    await fetchReminders();
    resetReminderForm();
    return editedReminder;
  }
}
