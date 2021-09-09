import 'package:flutter/material.dart';
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
    return Form(
      key: controller.signupFormKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Name",
              prefixIcon: Icon(Icons.person),
            ),
            keyboardType: TextInputType.name,
            controller: null,
            onSaved: (value) {
              controller.name = value!;
            },
            validator: (value) {
              return controller.validateName(value!);
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            controller: null,
            onSaved: (value) {
              controller.email = value!;
            },
            validator: (value) {
              return controller.validateEmail(value!);
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            key: controller.passKey,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Password",
              prefixIcon: Icon(Icons.lock),
            ),
            keyboardType: TextInputType.visiblePassword,
            controller: null,
            onSaved: (value) {
              controller.password = value!;
            },
            validator: (value) {
              return controller.validatePassword(value!);
            },
            obscureText: true,
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Confirm password",
              prefixIcon: Icon(Icons.lock),
            ),
            keyboardType: TextInputType.visiblePassword,
            controller: null,
            onSaved: (value) {
              controller.confirmPassword = value!;
            },
            validator: (value) {
              return controller.validateConfirmPassword(value!);
            },
            obscureText: true,
          ),
          SizedBox(
            height: 16,
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: context.width),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurpleAccent),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              onPressed: () {
                controller.checkSignUp();
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
