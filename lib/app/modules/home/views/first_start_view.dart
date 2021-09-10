import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_healthcare/app/modules/home/controllers/first_start_controller.dart';
import 'package:get/get.dart';

class FirstStartView extends StatefulWidget {
  const FirstStartView({Key? key}) : super(key: key);

  @override
  _FirstStartViewState createState() => _FirstStartViewState();
}

class _FirstStartViewState extends State<FirstStartView> {
  final FirstStartController firstStartController =
      Get.put(FirstStartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image(
              image: AssetImage('assets/images/first_start_icon.png'),
              width: 186,
              height: 100),
          CarouselSlider.builder(
            carouselController: firstStartController.controller,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width + 50,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) =>
                  setState(() => firstStartController.activeIndex = index),
            ),
            itemCount: firstStartController.urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = firstStartController.urlImages[index];
              final textBelowImage =
                  firstStartController.textBelowImages[index];
              final note = firstStartController.notes[index];
              return firstStartController.buildImage(
                  urlImage, textBelowImage, note, index);
            },
          ),
        ]),
        firstStartController.buildIndicator(),
        Obx(() => ConstrainedBox(
              constraints: BoxConstraints(minWidth: 100, minHeight: 50),
              child: TextButton(
                onPressed: firstStartController.next,
                child: Text(
                  '${firstStartController.textButton}',
                  style: TextStyle(fontSize: 24),
                ),
                style: firstStartController.buttonStyle.value,
              ),
            ))
      ],
    )));
  }
}
