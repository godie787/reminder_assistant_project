import 'package:flutter/material.dart';
import 'package:reminder_assistant/constants/messages.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/presentation/widgets/home/reminder_card.dart';

class RemindersListView extends StatelessWidget {
  final List reminders;
  final bool isEditing;
  final bool isDeleting;
  final Function(Reminder) onCardTap;

  const RemindersListView(
      {super.key,
      required this.reminders,
      required this.isEditing,
      required this.isDeleting,
      required this.onCardTap});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    if (reminders.isEmpty) {
      return Container(
          height: size.height * 0.6,
          color: Colors.transparent,
          child: const Center(child: Text(Messages.emptyReminders)));
    }

    return Container(
      height: size.height * 0.65,
      color: Colors.transparent,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return ReminderCard(
            reminder: reminder,
            isEditing: isEditing,
            isDeleting: isDeleting,
            onTap: onCardTap,
          );
        },
      ),
    );
  }
}
