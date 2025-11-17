import 'package:flutter/material.dart';
import 'package:reminder_assistant/presentation/widgets/home/add_or_delete_button_reminder.dart';

class HeaderSection extends StatelessWidget {
  final VoidCallback redirectToAdd;
  final VoidCallback isDeletingReminder;
  final VoidCallback addReminder;

  const HeaderSection(
      {super.key,
      required this.redirectToAdd,
      required this.isDeletingReminder,
      required this.addReminder});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddOrDeleteButtonReminder(
              imagePath: 'assets/images/addReminder.png',
              color: Color(0xff26C46C),
              name: 'add',
              onPressed: addReminder,
            ),
            SizedBox(
              width: 169,
              height: 65,
              child: Center(
                  child: Text('Añade o elimina tus recordatorios',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff666666)))),
            ),
            AddOrDeleteButtonReminder(
              imagePath: 'assets/images/deleteReminder.png',
              color: Color(0xffDE2323),
              name: 'delete',
              onPressed: isDeletingReminder,
            ),
          ],
        ));
  }
}
