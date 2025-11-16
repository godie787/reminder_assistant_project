import 'package:flutter/material.dart';
import 'package:reminder_assistant/presentation/widgets/add_reminder/date_section.dart';

class DateTitleDescriptionAndDateSection extends StatelessWidget {
  const DateTitleDescriptionAndDateSection(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.topLeft,
        child: Text('Fecha',
            style: TextStyle(
                fontSize: 24,
                color: Color(0xff000000),
                fontWeight: FontWeight.bold)),
      ),
      SizedBox(height: 16),
      Container(
        alignment: Alignment.topLeft,
        child: Text('Añade la fecha de repetición del recordatorio',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xff000000),
                fontWeight: FontWeight.w400)),
      ),
      SizedBox(height: 16),
      DateSection(),
      SizedBox(height: 36),
    ]);
  }
}
