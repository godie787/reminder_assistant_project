import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_assistant/domain/entities/user/user.dart';

class UserDatasource {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String dbCollection = 'users';

  Future<User?> getCurrentUser() async {
    final fbUser = fb.FirebaseAuth.instance.currentUser;

    if (fbUser == null) return null;

    return User(
      id: fbUser.uid,
      name: fbUser.displayName ?? '',
      email: fbUser.email ?? '',
    );
  }

  Future<User> createUser(User user) async {
    try {
      final docRef = db.collection(dbCollection).doc(user.id);
      final doc = await docRef.get();

      if (!doc.exists) {
        await docRef.set({
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } catch (e) {
      print("Error creating user in Firestore: $e");
      rethrow;
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      final doc = await db.collection(dbCollection).doc(id).get();

      if (!doc.exists) return null;

      final data = doc.data()!;
      return User(
        id: data['id'] as String,
        name: data['name'] as String,
        email: data['email'] as String,
      );
    } catch (e) {
      print("Error getting user from Firestore: $e");
      rethrow;
    }
  }
}
