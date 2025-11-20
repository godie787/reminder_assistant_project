import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/presentation/widgets/home/edit_reminder.dart';
import 'package:reminder_assistant/presentation/widgets/home/header_section.dart';
import 'package:reminder_assistant/presentation/widgets/home/home_reminders_section.dart';
import 'package:reminder_assistant/presentation/widgets/home/reminder_detail_dialog.dart';
import 'package:reminder_assistant/presentation/widgets/login/logout_alert_dialog.dart';
import 'package:reminder_assistant/providers/auth_provider.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ReminderProvider>().fetchReminders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reminderProvider = context.watch<ReminderProvider>();
    final authProvider = context.watch<AuthenticationProvider>();
    final isEditing = reminderProvider.isEditing;
    final isDeleting = reminderProvider.isDeleting;
    final isAdding = reminderProvider.isAdding;
    final reminders = reminderProvider.reminders;
    final initialLoading = reminderProvider.initialLoading;

    void redirectToAddReminder() {
      context.push('/add_reminder');
    }

    void addReminder() {
      if (isEditing) {
        reminderProvider.setIsEditing(false);
        return;
      }

      if (isDeleting) {
        reminderProvider.setIsDeleting(false);
        return;
      }

      if (reminderProvider.isAdding) {
        reminderProvider.setIsAdding(false);
        return;
      }
      reminderProvider.resetReminderForm();
      reminderProvider.setIsAdding(true);
      redirectToAddReminder();
    }

    void editReminder() {
      if (isAdding) {
        reminderProvider.setIsAdding(false);
        return;
      }

      if (isDeleting) {
        reminderProvider.setIsDeleting(false);
        return;
      }

      if (isEditing) {
        reminderProvider.setIsEditing(false);
        return;
      }
      reminderProvider.setIsEditing(true);
    }

    void isDeletingReminder() {
      if (isEditing) {
        reminderProvider.setIsEditing(false);
        return;
      }

      if (isAdding) {
        reminderProvider.setIsAdding(false);
        return;
      }

      if (reminderProvider.isDeleting) {
        reminderProvider.setIsDeleting(false);
        return;
      }
      reminderProvider.setIsDeleting(true);
    }

    void handleCardAction(Reminder reminder) {
      if (isEditing) {
        context.push('/edit_reminder/${reminder.id}');
        return;
      }

      if (isDeleting) {
        reminderProvider.deleteReminder(reminder.id);
        return;
      }

      reminderProvider.setIsReading(true);

      showDialog(
        context: context,
        builder: (_) => ReminderDetailDialog(
          reminder: reminder,
          onClose: () {
            reminderProvider.setIsReading(false);
            Navigator.of(context).pop();
          },
        ),
      );
    }

    if (initialLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        final shouldLogOut = await showDialog<bool>(
              context: context,
              builder: (context) => LogoutAlertDialog(
                onConfirm: () async {
                  await authProvider.signOut();
                  return true;
                },
              ),
            ) ??
            false;

        if (shouldLogOut) {
          await authProvider.signOut();
          reminderProvider.clearReminders();
          context.go('/login');
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xffD9D9D9),
        body: SafeArea(
          child: Column(
            children: [
              HeaderSection(
                redirectToAdd: redirectToAddReminder,
                isDeletingReminder: isDeletingReminder,
                addReminder: addReminder,
              ),
              SizedBox(height: 20),
              EditReminder(editReminder: editReminder),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      RemindersListView(
                        reminders: reminders,
                        isEditing: isEditing,
                        isDeleting: isDeleting,
                        onCardTap: handleCardAction,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
