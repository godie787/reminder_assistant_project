import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/presentation/widgets/home/edit_reminder.dart';
import 'package:reminder_assistant/presentation/widgets/home/header_section.dart';
import 'package:reminder_assistant/presentation/widgets/home/home_reminders_section.dart';
import 'package:reminder_assistant/presentation/widgets/home/read_more_button.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderProvider = context.watch<ReminderProvider>();
    final isEditing = reminderProvider.isEditing;
    final isDeleting = reminderProvider.isDeleting;
    final isAdding = reminderProvider.isAdding;
    final isViewing = reminderProvider.isViewing;
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
      } else if (isDeleting) {
        reminderProvider.deleteReminder(reminder.id);
      } else if (isViewing) {
        reminderProvider.setIsViewing(true);
      }
    }

    if (initialLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        reminderProvider.resetAllStates();
      },
      child: Scaffold(
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
                      // SizedBox(height: 20),
                      // ReadMoreButton(),
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
