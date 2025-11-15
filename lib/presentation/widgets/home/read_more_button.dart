import 'package:flutter/material.dart';

class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      width: 212,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF909090),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Center(
          child: Text(
            'Lee más sobre la aplicación aquí',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
