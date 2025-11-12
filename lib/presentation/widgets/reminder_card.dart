import 'package:flutter/material.dart';
import 'package:reminder_assistant/domain/entities/reminder.dart';

class ReminderCard extends StatelessWidget {
  final Reminder? reminder;

  const ReminderCard({super.key, this.reminder});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reminder!.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(reminder!.description),
            const SizedBox(height: 8),
            Text('Frecuencia: ${reminder!.frequency}'),
            Text('Estado: ${reminder!.status}'),
            const SizedBox(height: 8),
            Text(
              'Fecha: ${reminder!.dateTime.toLocal()}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
