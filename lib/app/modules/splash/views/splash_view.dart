import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_healthcare/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController splashController = Get.put(SplashController());
  var buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.blueAccent))));
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
            carouselController: splashController.controller,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width + 50,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) =>
                  setState(() => splashController.activeIndex = index),
            ),
            itemCount: splashController.urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = splashController.urlImages[index];
              final textBelowImage = splashController.textBelowImages[index];
              final note = splashController.notes[index];
              return buildImage(urlImage, textBelowImage, note, index);
            },
          ),
        ]),
        buildIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 100, minHeight: 50),
          child: TextButton(
            onPressed: splashController.next,
            child: Text(
              splashController.textButton,
              style: TextStyle(fontSize: 20),
            ),
            style: buttonStyle,
          ),
        )
      ],
    )));
  }

  Widget buildImage(
          String urlImage, String textBelowImage, String note, int index) =>
      Container(
          padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                  Text(textBelowImage, style: TextStyle(fontSize: 20)),
                  Text(note)
                ])
              ]));

  Widget buildIndicator() {
    setState(() {
      if (splashController.activeIndex ==
          splashController.urlImages.length - 1) {
        splashController.textButton = 'NEXT';
        buttonStyle = ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.blueAccent))));
      } else {
        splashController.textButton = 'SKIP';
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
        activeIndex: splashController.activeIndex,
        count: splashController.urlImages.length);
  }
}
