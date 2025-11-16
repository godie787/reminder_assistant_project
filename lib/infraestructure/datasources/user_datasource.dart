import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:reminder_assistant/domain/entities/user/user.dart';

class UserDatasource {
  Future<User?> getCurrentUser() async {
    final fbUser = fb.FirebaseAuth.instance.currentUser;

    if (fbUser == null) return null;

    return User(
      id: fbUser.uid,
      name: fbUser.displayName ?? '',
      email: fbUser.email ?? '',
    );
  }
}
