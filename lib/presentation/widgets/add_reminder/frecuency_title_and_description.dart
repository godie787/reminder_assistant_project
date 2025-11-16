import 'package:flutter/material.dart';

class FrecuencyTitleAndDescription extends StatelessWidget {
  const FrecuencyTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text('Frecuencia',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 16),
        Container(
          alignment: Alignment.topLeft,
          child: Text('Añade la frecuencia de repetición del recordatorio',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
