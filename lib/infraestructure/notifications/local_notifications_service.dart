import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class LocalNotificationsService {
  LocalNotificationsService._internal();
  static final LocalNotificationsService instance =
      LocalNotificationsService._internal();
  factory LocalNotificationsService() => instance;

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init({
    required Function(int reminderId) onCompleteFromNotification,
  }) async {
    if (_initialized) return;

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Santiago'));

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);

    await plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleNotificationResponse(response, onCompleteFromNotification);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    _initialized = true;
  }

  Future<void> scheduleReminderNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    print("Hora actual (local): $now");

    final tzDate = tz.TZDateTime.from(dateTime, tz.local);
    print("Hora del recordatorio (convertida): $tzDate");

    if (tzDate.isBefore(now)) {
      print("La hora de la notificación ya ha pasado. No se programará.");
      return; 
    }

    print("La notificación será programada para: $tzDate");

    final androidDetails = AndroidNotificationDetails(
      'reminders_channel',
      'Recordatorios',
      channelDescription: 'Notificaciones de recordatorios',
      importance: Importance.max,
      priority: Priority.high,
      actions: const [
        AndroidNotificationAction(
          'COMPLETE_ACTION',
          'Marcar como completado',
          showsUserInterface: false,
        ),
      ],
    );

    final details = NotificationDetails(android: androidDetails);

    final payload = jsonEncode({
      'reminderId': id,
    });

    try {
      await plugin.zonedSchedule(
        id,
        title,
        body,
        tzDate,
        details,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
      print("Notificación programada correctamente para: $tzDate");
    } catch (e) {
      print("Error al programar la notificación: $e");
    }
  }

  Future<void> cancelReminderNotification(int id) async {
    await plugin.cancel(id);
  }

  Future<void> cancelAll() async {
    await plugin.cancelAll();
  }

  void _handleNotificationResponse(
    NotificationResponse response,
    Function(int reminderId) onCompleteFromNotification,
  ) {
    if (response.actionId == 'COMPLETE_ACTION' ||
        response.notificationResponseType ==
            NotificationResponseType.selectedNotificationAction) {
      final payload = response.payload;
      if (payload == null) return;

      final data = jsonDecode(payload) as Map<String, dynamic>;
      final reminderId = data['reminderId'] as int;

      onCompleteFromNotification(reminderId);
    }
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  final service = LocalNotificationsService();
  service._handleNotificationResponse(response, (reminderId) {
    print(
        "Recordatorio $reminderId marcado como completado desde notificación en segundo plano");
  });
}
