import 'package:flutter/material.dart';
import 'package:reminder_assistant/domain/entities/user/user.dart';
import 'package:reminder_assistant/domain/use_cases/user/user_use_case.dart';

class AuthenticationProvider extends ChangeNotifier {
  final UserUseCase userUseCase;

  User? currentUser;
  bool isCheckingAuth = true;

  AuthenticationProvider({required this.userUseCase}) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    currentUser = await userUseCase.getUser();
    isCheckingAuth = false;
    notifyListeners();
  }
}
