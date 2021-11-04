import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/booked_success_controller.dart';

class BookedSuccessView extends GetView<BookedSuccessController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Background(height: size.height),
          Column(
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
                        'Đặt lịch hẹn thành công!',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  'Chúng tôi sẽ thông báo cho bạn ngay khi bác sĩ chấp nhận lịch hẹn.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFFA3A3A3),
                  ),
                ),
              ),
              CustomButton(
                width: size.width * 0.6,
                height: size.height * 0.05,
                text: "Trở về màn hình chính",
                onPressed: () {
                  Get.offAllNamed(Routes.HOME);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
