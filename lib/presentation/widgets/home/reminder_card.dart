import 'package:flutter/material.dart';
import 'package:reminder_assistant/domain/entities/reminder/reminder.dart';
import 'package:reminder_assistant/utils/date_utils.dart';

class ReminderCard extends StatelessWidget {
  final Reminder? reminder;
  final bool isEditing;
  final bool isDeleting;
  final Function(Reminder) onTap;

  const ReminderCard(
      {super.key,
      this.reminder,
      required this.isEditing,
      required this.isDeleting,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 258,
        height: 271,
        child: GestureDetector(
          onTap: () => onTap(reminder!),
          child: Card(
            color: Color(0xFF0078D7),
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isEditing
                    ? Color(0xffD97015)
                    : isDeleting
                        ? Color(0xffDE2323)
                        : Colors.transparent,
                width: isEditing
                    ? 4
                    : isDeleting
                        ? 4
                        : 0,
              ),
            ),
            // elevation: 20,
            // shadowColor: isEditing
            //     ? Color(0xffD97015)
            //     : isDeleting
            //         ? Color(0xffDE2323)
            //         : Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 30),
                    child: Center(
                      child: Text(
                        reminder!.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(
                        reminder!.frequency.toUpperCase() +
                            (reminder!.frequency.toLowerCase() == 'semanal'
                                ? ' (${reminder!.selectedDays.join(', ')})'
                                : ''),
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text(
                        '${MyDateUtils.getHourFromDate(reminder!.dateTime)}:${MyDateUtils.getMinutesFromDate(reminder!.dateTime)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFFFFFFFF),
                    thickness: 1,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      isEditing
                          ? 'TOCA PARA EDITAR'
                          : isDeleting
                              ? 'TOCA PARA ELIMINAR'
                              : 'TOCA PARA LEER',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
