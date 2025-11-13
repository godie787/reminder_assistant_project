import 'package:flutter/material.dart';

class AddOrDeleteButtonReminder extends StatelessWidget {
  final String imagePath;
  final Color color;
  final String name;
  final VoidCallback onPressed;

  const AddOrDeleteButtonReminder({
    super.key,
    required this.imagePath,
    required this.color,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 68,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Image(image: AssetImage(imagePath)),
      ),
    );
  }
}
