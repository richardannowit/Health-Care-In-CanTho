import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/forgotpassword_controller.dart';

class ForgotpasswordView extends GetView<ForgotpasswordController> {
  final formStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 7),
        blurRadius: 20,
        color: Colors.grey.withOpacity(0.23),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                height: 320,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Forgot your password?',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 220,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        decoration: formStyle,
                        child: Obx(() => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Please enter the email you use to sign in app.',
                                    style: TextStyle(fontSize: 16)),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextField(
                                        onChanged: (text) {
                                          controller.email = text;
                                          controller.text.value = "";
                                          if (GetUtils.isEmail(text) &&
                                              !controller.success) {
                                            controller.bgColor.value =
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blueAccent);
                                            controller.fgColor.value =
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white);
                                          } else {
                                            controller.bgColor.value =
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white);
                                            controller.fgColor.value =
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blueAccent);
                                          }
                                        },
                                        decoration: const InputDecoration(
                                            hintText: 'Ex: urser1@gmail.com',
                                            prefixIcon: Icon(Icons.email)),
                                      ),
                                      Text(
                                        controller.text.value,
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ]),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.offAllNamed(Routes.LOGIN);
                                        },
                                        child: Text('Back to login')),
                                    TextButton(
                                        onPressed: () {
                                          if (GetUtils.isEmail(
                                                  controller.email) &&
                                              !controller.success) {
                                            controller.auth
                                                .sendPasswordResetEmail(
                                                    email: controller.email);
                                            Get.snackbar('Success!',
                                                'A password recovery message has been sent to your email');
                                            controller.success = true;
                                            controller.bgColor.value =
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white);
                                            controller.fgColor.value =
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blueAccent);
                                          } else if (controller.success) {
                                            controller.text.value =
                                                "Please check your email!";
                                          } else {
                                            controller.text.value =
                                                "Please enter your exact email!";
                                          }
                                        },
                                        child: Text('SUBMIT',
                                            style: TextStyle(fontSize: 14)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              controller.bgColor.value,
                                          foregroundColor:
                                              controller.fgColor.value,
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              side: BorderSide(
                                                  color: Colors.blueAccent),
                                            ),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            )))
                  ],
                ))));
  }
}
