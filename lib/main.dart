import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/app_dependencies.dart';
import 'package:reminder_assistant/config/router/app_router.dart';
import 'package:reminder_assistant/providers/login_provider.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

void main() {
  final deps = AppDependencies();
  runApp(MainApp(deps: deps));
}

class MainApp extends StatelessWidget {
  final AppDependencies deps;

  const MainApp({super.key, required this.deps});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ReminderProvider(reminderUseCase: deps.reminderUseCase)
            ..fetchReminders(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
