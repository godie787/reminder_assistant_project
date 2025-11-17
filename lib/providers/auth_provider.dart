import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reminder_assistant/domain/entities/user/user.dart';
import 'package:reminder_assistant/domain/use_cases/user/user_use_case.dart';

class AuthenticationProvider extends ChangeNotifier {
  final UserUseCase? userUseCase;

  User? currentUser;
  bool isCheckingAuth = true;

  AuthenticationProvider({ this.userUseCase}) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    currentUser = await userUseCase?.getUser();
    isCheckingAuth = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await fb_auth.FirebaseAuth.instance.signOut();

      currentUser = null; 
      notifyListeners(); 
    } catch (e) {
      print("Error durante el cierre de sesión: $e");
    }
  }
}
