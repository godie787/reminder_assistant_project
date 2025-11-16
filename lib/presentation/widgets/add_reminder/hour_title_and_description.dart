import 'package:flutter/material.dart';

class HourTitleAndDescription extends StatelessWidget {
  const HourTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text('Horario',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 16),
        Container(
          alignment: Alignment.topLeft,
          child: Text('Añade una hora para el recordatorio',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
