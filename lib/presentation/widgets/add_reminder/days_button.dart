import 'package:flutter/material.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class DaysButton extends StatelessWidget {
  final String day;
  final ReminderProvider provider;
  const DaysButton({super.key, required this.day, required this.provider});

  @override
  Widget build(BuildContext context) {
    bool isSelected = provider.selectedDays.contains(day);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          provider.handleDaySelection(day);
        },
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              provider.handleDaySelection(day);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected
                  ? Color(0xFFD01664)
                  : Colors
                      .transparent, // Cambiamos el color si está seleccionado
              elevation: 0,
              side: BorderSide(
                  color: isSelected ? Color(0xFFD01664) : Color(0xFFD01664),
                  width: 3),
            ),
            child: Text(
              day,
              style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Color(
                          0xFFD01664),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
