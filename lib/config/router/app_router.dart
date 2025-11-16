import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reminder_assistant/presentation/screens/add_or_edit_reminder_screen.dart';
import 'package:reminder_assistant/presentation/screens/home_screen.dart';
import 'package:reminder_assistant/presentation/screens/login_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
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
            return const AddOrEditReminderScreen();
          },
        ),
        GoRoute(
          path: '/edit_reminder/:id',
          builder: (BuildContext context, GoRouterState state) {
            final int id = int.parse(state.pathParameters['id']!);
            return AddOrEditReminderScreen(reminderId: id);
          },
        ),
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
      ],
    ),
  ],
);
