import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/app_dependencies.dart';
import 'package:reminder_assistant/config/router/app_router.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:reminder_assistant/providers/auth_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final reminderDependencies = ReminderDependencies();
  final userDependencies = UserDependencies();
  runApp(MainApp(deps: reminderDependencies, userDeps: userDependencies));
}

class MainApp extends StatelessWidget {
  final ReminderDependencies deps;
  final UserDependencies userDeps;

  const MainApp({super.key, required this.deps, required this.userDeps});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ReminderProvider(reminderUseCase: deps.reminderUseCase)
            ..fetchReminders(),
        ),
        ChangeNotifierProvider(
            create: (_) =>
                AuthenticationProvider(userUseCase: userDeps.userUseCase)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
