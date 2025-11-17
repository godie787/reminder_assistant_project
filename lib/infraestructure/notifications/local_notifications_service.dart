import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class LocalNotificationsService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    try {
      const initAndroidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const initIOSSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initSettings = InitializationSettings(
        android: initAndroidSettings,
        iOS: initIOSSettings,
      );

      await notificationsPlugin.initialize(initSettings);
      _initialized = true;

      _createNotificationChannel();
      print("Notification service initialized successfully.");
    } catch (e, stackTrace) {
      throw Exception(
          "Error initializing notification service: $e\nStackTrace: $stackTrace");
    }
  }

  void _createNotificationChannel() {
    try {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'reminder_channel',
        'Reminder Notifications',
        description: 'Channel for Reminder notifications',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      );

      notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    } catch (e, stackTrace) {
      throw Exception(
          "Error creating notification channel: $e\nStackTrace: $stackTrace");
    }
  }

  NotificationDetails notificationDetails() {
    try {
      return NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminder Notifications',
          channelDescription: 'Channel for Reminder notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(),
      );
    } catch (e, stackTrace) {
      throw Exception(
          "Error setting notification details: $e\nStackTrace: $stackTrace");
    }
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    try {
      await notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(),
      );
    } catch (e, stackTrace) {
      throw Exception(
          "Error showing notification: $e\nStackTrace: $stackTrace");
    }
  }

  // - hour (0-23)
  // - minute (0-59)

  Future<void> scheduleNotification({
    required int id,
    String? title,
    String? body,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
    List<String>? selectedDays,
  }) async {
    if (selectedDays != null && selectedDays.isNotEmpty) {
      for (String day in selectedDays) {
        int weekday = _getWeekdayFromString(day);

        var scheduledDate =
            _getNextWeekdayDate(year, month, weekday, hour, minute);

        try {
          await notificationsPlugin.zonedSchedule(
            id,
            title,
            body,
            scheduledDate,
            notificationDetails(),
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.time,
          );
          print("Scheduled notification for $day on $scheduledDate");
        } catch (e, stackTrace) {
          print("Error scheduling notification for $day: $e\n$stackTrace");
        }
      }
    } else {
      var scheduledDate =
          tz.TZDateTime(tz.local, year, month, day, hour, minute);
      try {
        await notificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          scheduledDate,
          notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
        print("Scheduled notification for unique date: $scheduledDate");
      } catch (e, stackTrace) {
        print("Error scheduling unique notification: $e\n$stackTrace");
      }
    }
  }

  int _getWeekdayFromString(String day) {
    switch (day.toLowerCase()) {
      case 'lunes':
        return DateTime.monday;
      case 'martes':
        return DateTime.tuesday;
      case 'miércoles':
        return DateTime.wednesday;
      case 'jueves':
        return DateTime.thursday;
      case 'viernes':
        return DateTime.friday;
      case 'sábado':
        return DateTime.saturday;
      case 'domingo':
        return DateTime.sunday;
      default:
        throw Exception("Invalid day string: $day");
    }
  }

  tz.TZDateTime _getNextWeekdayDate(
      int year, int month, int weekday, int hour, int minute) {
    var now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, year, month, now.day, hour, minute);

    if (scheduledDate.weekday <= weekday) {
      scheduledDate =
          scheduledDate.add(Duration(days: weekday - scheduledDate.weekday));
    } else {
      scheduledDate = scheduledDate
          .add(Duration(days: 7 - (scheduledDate.weekday - weekday)));
    }
    return scheduledDate;
  }

  Future<void> cancelAllNotifications() async {
    try {
      await notificationsPlugin.cancelAll();
    } catch (e, stackTrace) {
      throw Exception(
          "Error cancelling all notifications: $e\nStackTrace: $stackTrace");
    }
  }
}
