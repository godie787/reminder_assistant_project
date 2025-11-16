import 'package:flutter/material.dart';
import 'package:reminder_assistant/constants/frecuencies.dart';

class FrecuencySection extends StatelessWidget {
  final Function(String) frecuencyAction;
  final String frecuency;

  const FrecuencySection(
      {super.key, required this.frecuencyAction, required this.frecuency});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: frecuency == Frecuencies.unique ? 70 : 60,
            child: ElevatedButton(
                onPressed: () {
                  frecuencyAction(Frecuencies.unique);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF83008C),
                  elevation: frecuency == Frecuencies.unique ? 10 : 0,
                  side: BorderSide(
                      color: frecuency == Frecuencies.unique
                          ? Color(0xFF26C46C)
                          : Colors.transparent,
                      width: 4),
                ),
                child: Text('Único',
                    style:
                        TextStyle(color: Color(0xFFFFFFFF), fontSize: 24))),
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          child: GestureDetector(
              onTap: () => {},
              child: SizedBox(
                height: frecuency == Frecuencies.weekly ? 70 : 60,
                child: ElevatedButton(
                    onPressed: () {
                      frecuencyAction(Frecuencies.weekly);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffD01664),
                      elevation: frecuency == Frecuencies.weekly ? 10 : 0,
                      side: BorderSide(
                          color: frecuency == Frecuencies.weekly
                              ? Color(0xFF26C46C)
                              : Colors.transparent,
                          width: 4),
                    ),
                    child: Text(
                      'Semanal',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24),
                    )),
              )),
        )
      ],
    );
  }
}
