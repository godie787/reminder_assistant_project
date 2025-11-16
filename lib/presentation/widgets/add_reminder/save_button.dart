import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 74,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF26C46C),
            ),
            child: Text(
              'GUARDAR Recordatorio',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24),
            )),
      ),
    ]);
  }
}
