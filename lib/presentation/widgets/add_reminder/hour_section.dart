import 'package:flutter/material.dart';
import 'hour_dialog.dart';

class HourSection extends StatelessWidget {
  final Function(DateTime) hourAction;
  final int hour;
  final int minute;
  final String amPm;

  const HourSection(
      {super.key,
      required this.hourAction,
      required this.hour,
      required this.minute,
      required this.amPm});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return HourDialog(hourAction: hourAction, hour: hour, minute: minute, amPm: amPm);
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xffE5E5E5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '$hour',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(':', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return HourDialog(hourAction: hourAction, hour: hour, minute: minute, amPm: amPm);
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xffE5E5E5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '$minute',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return HourDialog(hourAction: hourAction, hour: hour, minute: minute, amPm: amPm);
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xffE5E5E5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  amPm,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
