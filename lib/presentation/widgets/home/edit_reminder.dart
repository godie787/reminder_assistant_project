import 'package:flutter/material.dart';

class EditReminder extends StatelessWidget {
  final VoidCallback editReminder;

  const EditReminder({super.key, required this.editReminder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 300,
      child: ElevatedButton(
          onPressed: editReminder,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD97015),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image(
                    image: AssetImage('assets/images/editReminder.png'),
                    width: 49,
                    height: 49),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'Editar Recordatorio',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ],
          )),
    );
  }
}
