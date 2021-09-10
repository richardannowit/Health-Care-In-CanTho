import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_healthcare/app/modules/home/controllers/first_start_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstStartView extends StatefulWidget {
  const FirstStartView({Key? key}) : super(key: key);

  @override
  _FirstStartViewState createState() => _FirstStartViewState();
}

class _FirstStartViewState extends State<FirstStartView> {
  final FirstStartController firstStartController =
      Get.put(FirstStartController());
  var buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.blueAccent))));
  String textButton = 'SKIP';
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
              return buildImage(urlImage, textBelowImage, note, index);
            },
          ),
        ]),
        buildIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 100, minHeight: 50),
          child: TextButton(
            onPressed: firstStartController.next,
            child: Text(
              textButton,
              style: TextStyle(fontSize: 24),
            ),
            style: buttonStyle,
          ),
        )
      ],
    )));
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

  Widget buildIndicator() {
    setState(() {
      if (firstStartController.activeIndex ==
          firstStartController.urlImages.length - 1) {
        textButton = 'NEXT';
        buttonStyle = ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.blueAccent))));
      } else {
        textButton = 'SKIP';
        buttonStyle = ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.blueAccent))));
      }
    });
    return AnimatedSmoothIndicator(
        activeIndex: firstStartController.activeIndex,
        count: firstStartController.urlImages.length);
  }
}
