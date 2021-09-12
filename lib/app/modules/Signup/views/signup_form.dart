import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/Signup/views/constants.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: controller.signupFormKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: formStyle,
        child: Column(
          children: [
            buildNameFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildEmailFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildPhoneFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildPasswordFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildConfirmPasswordFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildSignUpButton(size),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 14),
                ),
                GestureDetector(
                  onTap: null,
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      decoration: inputStyle.copyWith(
        hintText: 'Name',
        prefixIcon: Icon(
          Icons.person,
        ),
      ),
      keyboardType: TextInputType.name,
      onSaved: (value) {
        controller.name = value!;
      },
      validator: (value) {
        return controller.validateName(value!);
      },
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: inputStyle.copyWith(
        hintText: 'Email',
        prefixIcon: Icon(
          Icons.email,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        controller.email = value!;
      },
      validator: (value) {
        return controller.validateEmail(value!);
      },
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      decoration: inputStyle.copyWith(
        hintText: 'Phone Number',
        prefixIcon: Icon(
          Icons.phone,
        ),
      ),
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        controller.phone = value!;
      },
      validator: (value) {
        return controller.validatePhone(value!);
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      key: controller.passKey,
      decoration: inputStyle.copyWith(
        hintText: 'Password',
        prefixIcon: Icon(
          Icons.lock,
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        controller.password = value!;
      },
      validator: (value) {
        return controller.validatePassword(value!);
      },
      obscureText: true,
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      decoration: inputStyle.copyWith(
        hintText: 'Confirm Password',
        prefixIcon: Icon(
          Icons.lock,
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        controller.confirmPassword = value!;
      },
      validator: (value) {
        return controller.validateConfirmPassword(value!);
      },
      obscureText: true,
    );
  }

  ConstrainedBox buildSignUpButton(Size size) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: size.width * 0.4,
        height: size.height * 0.05,
      ),
      child: ElevatedButton(
        style: buttonStyle,
        child: Text(
          "SIGN UP",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        onPressed: () {
          controller.checkSignUp();
        },
      ),
    );
  }
}
