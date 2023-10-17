import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // ignore: body_might_complete_normally_nullable
  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              //when work with intrnet use await
              email: email,
              password: password);
      return userCredential.user;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static signOut() {}

  Future<Map<String, dynamic>?> getUserDetails(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection("doctors")
              .where("email", isEqualTo: email)
              .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDoc = userSnapshot.docs[0];
        return userDoc.data();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
