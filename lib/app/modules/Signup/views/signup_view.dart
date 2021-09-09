import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/Signup/views/signup_form.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: Column(
              children: [
                CircleAvatar(
                  child: Image.asset(
                    'assets/avt_doctor.png',
                    width: 500,
                    height: 500,
                  ),
                  minRadius: 70,
                  maxRadius: 70,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Create An Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SignUpForm(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
