import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Users(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future signUpWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User? firebaseUser = result.user;
  //     return _userFromFirebaseUser(firebaseUser!);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}
