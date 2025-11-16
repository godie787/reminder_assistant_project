import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reminder_assistant/presentation/screens/add_reminder_screen.dart';
import 'package:reminder_assistant/presentation/screens/home_screen.dart';
import 'package:reminder_assistant/presentation/screens/login_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: 'add_reminder',
          builder: (BuildContext context, GoRouterState state) {
            return const AddReminderScreen();
          },
        ),
      ],
    ),
  ],
);
