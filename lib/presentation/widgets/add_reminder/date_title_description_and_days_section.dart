import 'package:flutter/material.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/days_section.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class DateTitleDescriptionAndDaysSection extends StatelessWidget {
  final ReminderProvider provider;
  const DateTitleDescriptionAndDaysSection({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.topLeft,
        child: Text('Días',
            style: TextStyle(
                fontSize: 24,
                color: Color(0xff000000),
                fontWeight: FontWeight.bold)),
      ),
      SizedBox(height: 16),
      Container(
        alignment: Alignment.topLeft,
        child: Text('Selecciona los días de repetición del recordatorio',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xff000000),
                fontWeight: FontWeight.w400)),
      ),
      SizedBox(height: 16),
      DaysSection(provider: provider),
      SizedBox(height: 36),
    ]);
  }
}
