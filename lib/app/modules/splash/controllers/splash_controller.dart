import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_healthcare/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final controller = CarouselController();
  int activeIndex = 0;
  String textButton = 'SKIP';
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
    if (activeIndex == urlImages.length - 1) {
      Get.to(HomeView());
    } else
      controller.nextPage();
  }
}
