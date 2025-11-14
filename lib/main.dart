import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/app_dependencies.dart';
import 'package:reminder_assistant/presentation/screens/home_screen.dart';
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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: HomeScreen()),
      ),
    );
  }
}
