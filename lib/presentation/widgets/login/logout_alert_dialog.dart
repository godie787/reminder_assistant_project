import 'package:flutter/material.dart';

class LogoutAlertDialog extends StatelessWidget {
  final Future<bool> Function() onConfirm;

  const LogoutAlertDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Color(
              0xFF0078D7),
          width: 3,
        ),
      ),
      title: Text(
        'Cerrar sesión',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0078D7),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          '¿Deseas cerrar sesión?',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(false), 
          style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(
                255, 198, 44, 44), 
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            bool shouldLogOut = await onConfirm(); 
            Navigator.of(context)
                .pop(shouldLogOut); 
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Color(0xFF26C46C), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: const Text(
            'Cerrar sesión',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
