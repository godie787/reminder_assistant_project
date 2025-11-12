import 'package:flutter/material.dart';
import 'package:reminder_assistant/presentation/widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    void onPressed(String name) {
      if (name == 'google_login') {
        print("Google login pressed");
      } else if (name == 'guest_login') {
        print("Guest login pressed");
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 140, left: 100, right: 100),
            child: SizedBox(
                height: 57,
                child: Image(image: AssetImage('assets/images/loginTop.png'))),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 30, left: 100, right: 100),
            child: Center(
                child: Text('Bienvenido/a',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ))),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(
                top: 30, left: 100, right: 100, bottom: 20),
            child: Center(
                child: Text('Elige cómo quieres entrar a la aplicación',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400))),
          ),
        ),
        LoginButton(
            name: 'google_login',
            color: Color(0xFF0078D7),
            text: 'Continuar con Google',
            imagePath: 'assets/images/googleIcon.png',
            onPressed: () => onPressed('google_login')),
        LoginButton(
            name: 'guest_login',
            color: Color(0xFFDF9100),
            text: 'Entrar sin cuenta',
            imagePath: 'assets/images/loginIcon.png',
            onPressed: () => onPressed('guest_login')),
      ],
    );
  }
}
