import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_healthcare/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> signupFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> passKey = GlobalKey<FormFieldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController nameController,
      emailController,
      phoneController,
      passwordController,
      confirmPasswordController;
  var name = '';
  var email = '';
  var phone = '';
  var password = '';
  var confirmPassword = '';

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  String? validateEmail(String email) {
    if (email.length < 1) {
      return 'Email is not empty';
    }
    if (!GetUtils.isEmail(email)) {
      return 'Please enter valid email';
    }
    return null;
  }

  String? validateName(String name) {
    if (name.length >= 255) {
      return 'Your name is no longer than 255 character';
    }
    if (name.length < 1) {
      return 'Your name is not empty';
    }
    return null;
  }

  String? validatePhone(String phone) {
    if (phone.length < 1) {
      return 'Phone number is not empty';
    }
    if (!GetUtils.isPhoneNumber(phone)) {
      return 'Please enter valid phone number';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 1) {
      return 'Password is not empty';
    }
    if (password.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String confirmPassword) {
    var password = passKey.currentState!.value;
    if (confirmPassword != password) {
      return "Password do not match.";
    }
    return null;
  }

  void checkSignUp() {
    final isValid = signupFormKey.currentState!.validate();
    if (!isValid) {
      print('Fail to validate');
      return;
    }
    signupFormKey.currentState!.save();
    createUser();
    // print("Sign up successfully");
  }

  void createUser() async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('users');

      Map<String, dynamic> userData = {
        'name': this.name,
        'email': this.email,
        'phone': this.phone,
      };
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: this.email, password: this.password);

      reference
          .doc(userCredential.user!.uid)
          .set(userData)
          .then((value) => Get.offAll(HomeView()));
      print("Sign up successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Sign up error!", "The password provided is too weak.",
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
            "Sign up error!", "The account already exists for that email.",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
