import 'package:flutter/material.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class HourDialog extends StatelessWidget {
  final Function(DateTime) hourAction;
  final int hour;
  final int minute;
  final String amPm;

  const HourDialog({
    super.key,
    required this.hourAction,
    required this.hour,
    required this.minute,
    required this.amPm,
  });

  @override
  Widget build(BuildContext context) {
    DateTime initialTime = DateTime(0, 0, 0, hour, minute);

    return AlertDialog(
      backgroundColor: Color(0xffD9D9D9),
      title: Center(
        child: Text(
          "Selecciona la hora",
          style: TextStyle(fontSize: 24),
        ),
      ),
      content: SizedBox(
        width: 300,
        height: 300,
        child: TimePickerSpinner(
          is24HourMode: true,
          time: initialTime,
          onTimeChange: (time) {
            hourAction(time);
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "GUARDAR",
            style: TextStyle(
              color: Color(0xFF26C46C),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
      insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
