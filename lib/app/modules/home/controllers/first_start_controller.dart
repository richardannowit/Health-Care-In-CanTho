import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstStartController extends GetxController {
  final controller = CarouselController();
  int activeIndex = 0;
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
  var buttonStyle = ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.blueAccent))))
      .obs;
  var textButton = 'SKIP'.obs;

  Widget buildIndicator() {
    if (activeIndex == urlImages.length - 1) {
      textButton = 'NEXT'.obs;
      buttonStyle = ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueAccent),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.blueAccent))))
          .obs;
    } else {
      textButton = 'SKIP'.obs;
      buttonStyle = ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueAccent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.blueAccent))))
          .obs;
    }
    return AnimatedSmoothIndicator(
        activeIndex: activeIndex, count: urlImages.length);
  }

  Widget buildImage(
          String urlImage, String textBelowImage, String note, int index) =>
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(urlImage),
              ),
            ),
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(textBelowImage, style: TextStyle(fontSize: 24)),
          Text(note)
        ])
      ]);

  next() {
    if (activeIndex == urlImages.length - 1) {
      Get.to(HomeView());
      print('Chuyen sang trang dang nhap');
    } else
      controller.nextPage();
  }
}
