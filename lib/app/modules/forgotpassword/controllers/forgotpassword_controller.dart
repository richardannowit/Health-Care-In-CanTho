import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotpasswordController extends GetxController {
  String email = "";
  bool success = false;
  final auth = FirebaseAuth.instance;
  forgotPassword() {
    auth.sendPasswordResetEmail(email: email);
    success = true;
  }
}
