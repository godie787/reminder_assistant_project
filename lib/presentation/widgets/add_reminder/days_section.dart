import 'package:flutter/material.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/days_button.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class DaysSection extends StatelessWidget {
  final ReminderProvider provider;
  const DaysSection({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            DaysButton(day: 'Lunes', provider: provider),
            SizedBox(width: size.width * 0.05),
            DaysButton(day: 'Martes', provider: provider),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            DaysButton(day: 'Miércoles', provider: provider),
            SizedBox(width: size.width * 0.05),
            DaysButton(day: 'Jueves', provider: provider),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            DaysButton(day: 'Viernes', provider: provider),
            SizedBox(width: size.width * 0.05),
            DaysButton(day: 'Sábado', provider: provider),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            DaysButton(day: 'Domingo', provider: provider),
          ],
        ),
      ],
    );
  }
}
