import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/presentation/screens/home_screen.dart';
import 'package:reminder_assistant/presentation/screens/login_screen.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ReminderProvider()..fetchReminders()),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: Scaffold(body: HomeScreen()),
          home: Scaffold(body: LoginScreen())),
    );
  }
}
