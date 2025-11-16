import 'package:flutter/material.dart';

class DescriptionInput extends StatelessWidget {
  final Function setDescriptionAction;
  final TextEditingController descriptionController;
  const DescriptionInput(
      {super.key,
      required this.descriptionController,
      required this.setDescriptionAction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descriptionController,
      style: TextStyle(
        fontSize: 20,
        color: Color(0xff000000),
      ),
      onChanged: (value) {
        setDescriptionAction(value);
      },
      decoration: InputDecoration(
        hintText: '${('Describe')} aquí tu recordatorio...',
        hintStyle: TextStyle(
          fontSize: 20,
          color: Color(0xff222222),
        ),
        filled: true,
        fillColor: Color(0xffD9D9D9),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 50,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF26C46C), width: 2),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(50)),
        ),
      ),
    );
  }
}
