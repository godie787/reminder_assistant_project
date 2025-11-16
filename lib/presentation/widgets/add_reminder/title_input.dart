import 'package:flutter/material.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 20,
        color: Color(0xff000000),
      ),
      decoration: InputDecoration(
        hintText: 'Título...',
        hintStyle: TextStyle(
          fontSize: 20,
          color: Color(0xff222222),
        ),

        filled: true,
        fillColor: Color(0xffD9D9D9),

        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
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
