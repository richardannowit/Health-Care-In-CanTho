import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final carouselController = Get.put(CarouselController());
  RxInt activeIndex = 0.obs;
  String textButton = 'Tiếp tục';
  var bgColor = MaterialStateProperty.all<Color>(Colors.white).obs;
  var fgColor = MaterialStateProperty.all<Color>(primaryColor).obs;
  final urlImages = [
    'assets/images/first_start_image_1.png',
    'assets/images/first_start_image_2.png',
    'assets/images/first_start_image_3.png'
  ];
  final textBelowImages = [
    'Đặt lịch hẹn',
    'Tìm kiếm bác sĩ',
    'Kết nối giữa bạn và bác sĩ'
  ];
  final notes = [
    'Dễ dàng đặt lịch hẹn với bác sĩ ngay tại nhà',
    'Cung cấp danh sách bác sĩ tốt nhất gần bạn',
    'Trò chuyện với bác sĩ mà bạn mong muốn về vấn đề sức khỏe'
  ];

  next() {
    if (activeIndex.value == urlImages.length - 1) {
      Get.toNamed(Routes.LOGIN);
    } else
      carouselController.nextPage();
  }

  changeButton(int index) {
    if (activeIndex.value == urlImages.length - 1) {
      bgColor = MaterialStateProperty.all<Color>(primaryColor).obs;
      fgColor = MaterialStateProperty.all<Color>(Colors.white).obs;
      textButton = 'Đăng nhập';
    } else {
      bgColor = MaterialStateProperty.all<Color>(Colors.white).obs;
      fgColor = MaterialStateProperty.all<Color>(primaryColor).obs;
      textButton = 'Tiếp tục';
    }
  }
}
