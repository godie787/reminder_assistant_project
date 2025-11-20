import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:reminder_assistant/domain/entities/user/user.dart' as app_user;
import 'package:reminder_assistant/domain/use_cases/user/user_use_case.dart';
import 'package:reminder_assistant/presentation/widgets/login/login_button.dart';
import 'package:reminder_assistant/providers/auth_provider.dart';
import 'package:reminder_assistant/providers/reminder_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<UserCredential?> signInWithGoogle() async {
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return null;
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        return userCredential;
      } catch (e) {
        return null;
      }
    }

    void onPressed(String name) async {
      if (name == 'google_login') {
        final result = await signInWithGoogle();

        if (result != null) {
          final userUseCase = context.read<UserUseCase>();
          final fbUser = result.user;

          if (fbUser != null) {
            final user = app_user.User(
              id: fbUser.uid,
              name: fbUser.displayName ?? '',
              email: fbUser.email ?? '',
            );

            try {
              await userUseCase.createUser(user);
            } catch (e) {
              print("Error saving user to Firestore: $e");
            }
          }

          await context.read<AuthenticationProvider>().checkAuthStatus();
          await context.read<ReminderProvider>().fetchReminders();
          context.go('/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al iniciar sesión con Google')),
          );
        }
      } else if (name == 'guest_login') {
        context.go('/home');
      }
    }

    final authProvider = context.watch<AuthenticationProvider>();

    if (authProvider.isCheckingAuth) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (authProvider.currentUser != null) {
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Bienvenido ${authProvider.currentUser!.name}',
            ),
          ),
        );

        context.go('/home');
      });
    }

    return Scaffold(
      backgroundColor: Color(0xffD9D9D9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 140, left: 100, right: 100),
                child: SizedBox(
                    height: 57,
                    child:
                        Image(image: AssetImage('assets/images/loginTop.png'))),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 30, left: 80, right: 80),
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
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF666666)))),
              ),
            ),
            LoginButton(
                name: 'google_login',
                color: Color(0xFF0078D7),
                text: 'Continuar con Google',
                imagePath: 'assets/images/googleIcon.png',
                onPressed: () => onPressed('google_login')),
            // LoginButton(
            //     name: 'guest_login',
            //     color: Color(0xFFDF9100),
            //     text: 'Entrar sin cuenta',
            //     imagePath: 'assets/images/loginIcon.png',
            //     onPressed: () => onPressed('guest_login')),
          ],
        ),
      ),
    );
  }
}
