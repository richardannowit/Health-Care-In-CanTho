import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final carouselController = CarouselController();
  RxInt activeIndex = 0.obs;
  String textButton = 'SKIP';
  var bgColor = MaterialStateProperty.all<Color>(Colors.white).obs;
  var fgColor = MaterialStateProperty.all<Color>(Colors.blueAccent).obs;
  final urlImages = [
    'assets/images/first_start_image_1.png',
    'assets/images/first_start_image_2.png',
    'assets/images/first_start_image_3.png'
  ];
  final textBelowImages = [
    'Booking appointment',
    'Searching doctors',
    'Contact with doctors'
  ];
  final notes = [
    'Easy to book appointment with doctor at home',
    'Get list of best doctor nearby you',
    'Chatting with doctor before you booking'
  ];

  next() {
    if (activeIndex.value == urlImages.length - 1) {
      Get.to(HomeView());
    } else
      carouselController.nextPage();
  }

  changeButton(int index) {
    if (activeIndex.value == urlImages.length - 1) {
      bgColor = MaterialStateProperty.all<Color>(Colors.blueAccent).obs;
      fgColor = MaterialStateProperty.all<Color>(Colors.white).obs;
      textButton = 'NEXT';
    } else {
      bgColor = MaterialStateProperty.all<Color>(Colors.white).obs;
      fgColor = MaterialStateProperty.all<Color>(Colors.blueAccent).obs;
      textButton = 'SKIP';
    }
  }
}
