import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/constants/messages.dart';
import 'package:reminder_assistant/presentation/widgets/custom_appbar.dart';
import 'package:reminder_assistant/presentation/widgets/reminder_card.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderProvider = context.watch<ReminderProvider>();

    return Scaffold(
        appBar: const CustomAppBar(),
        body: Container(
            color: const Color.fromARGB(255, 235, 255, 250),
            child: Column(
              children: [
                Text('Aquí irán los filtros por fecha y estado'),
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
