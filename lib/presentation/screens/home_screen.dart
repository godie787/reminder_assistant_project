import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/constants/messages.dart';
import 'package:reminder_assistant/presentation/widgets/home/edit_reminder.dart';
import 'package:reminder_assistant/presentation/widgets/home/header_section.dart';
import 'package:reminder_assistant/presentation/widgets/home/reminder_card.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderProvider = context.watch<ReminderProvider>();

    void redirectToAddReminder() {
      print('redireccionar a la pantalla de agregar recordatorio');
    }

    void redirectToDeleteReminder() {
      print('redireccionar a la pantalla de eliminar recordatorio');
    }

    void editReminder() {
      print('Implementar lógica para editar recordatorios');
    }

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        HeaderSection(
          redirectToAdd: redirectToAddReminder,
          redirectToDelete: redirectToDeleteReminder,
        ),
        SizedBox(height: 20),
        EditReminder(editReminder: editReminder),
        Expanded(child: _builListView(reminderProvider)),
      ],
    )));
  }

  Widget _builListView(ReminderProvider reminderProvider) {
    if (reminderProvider.initialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (reminderProvider.reminders.isEmpty) {
      return const Center(child: Text(Messages.emptyReminders));
    }

    return ListView.builder(
      itemCount: reminderProvider.reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminderProvider.reminders[index];
        return ReminderCard(reminder: reminder);
      },
    );
  }
}
