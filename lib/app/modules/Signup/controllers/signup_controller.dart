import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> signupFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> passKey = GlobalKey<FormFieldState>();

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
      return 'Your name is not empty';
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
      return "The password confirmation does not match.";
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
    print("name = " + name);
    print('email = ' + email);
    print('email = ' + phone);
    print('password = ' + password);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
