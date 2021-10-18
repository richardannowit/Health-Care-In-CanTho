import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/booked_success/views/components/custom_button.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/booked_success_controller.dart';

class BookedSuccessView extends GetView<BookedSuccessController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/success.gif'),
                  height: 150.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Appointment Booked Successfully!',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF303030),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text(
              'We will contact you as soon as possible. Please be available on time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFF808080),
              ),
            ),
          ),
          CustomButton(
            width: size.width * 0.5,
            height: size.height * 0.05,
            text: "Return to Home Page",
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
          ),
        ],
      ),
    );
  }
}
