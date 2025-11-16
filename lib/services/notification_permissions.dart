import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  final permissionStatus = await Permission.notification.request();

  if (permissionStatus.isGranted) {
    print('Permiso de notificación concedido');
  } else {
    print('Permiso de notificación denegado');
  }
}
