import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback saveOrEditReminder;
  final bool isAdding;
  final bool isEditing;
  final bool isDisabled;

  const SaveButton(
      {super.key,
      required this.saveOrEditReminder,
      required this.isAdding,
      required this.isEditing,
      required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 74,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: isDisabled ? null : saveOrEditReminder,
            style: ElevatedButton.styleFrom(
              backgroundColor: isAdding
                  ? Color(0xFF26C46C)
                  : isEditing
                      ? Color(0xFFD97015)
                      : Color(0xFF26C46C),
            ),
            child: Text(
              isAdding
                  ? 'Guardar Recordatorio'
                  : isEditing
                      ? 'Guardar Cambios'
                      : 'Guardar Recordatorio',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24),
            )),
      ),
    ]);
  }
}
