import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashView extends GetView<SplashController> {
  final Color? color = Colors.green[100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Obx(() => Stack(
                  children: [
                    Background(height: MediaQuery.of(context).size.height),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  image: AssetImage(
                                      'assets/images/first_start_icon.png'),
                                  width: 186,
                                  height: 100),
                              CarouselSlider.builder(
                                carouselController:
                                    controller.carouselController,
                                options: CarouselOptions(
                                    height:
                                        MediaQuery.of(context).size.width + 50,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    onPageChanged: (index, reason) {
                                      controller.activeIndex.value = index;
                                      controller.changeButton(index);
                                    }),
                                itemCount: controller.urlImages.length,
                                itemBuilder: (context, index, realIndex) {
                                  final urlImage = controller.urlImages[index];
                                  final textBelowImage =
                                      controller.textBelowImages[index];
                                  final note = controller.notes[index];
                                  return buildImage(
                                      urlImage, textBelowImage, note, index);
                                },
                              ),
                            ]),
                        buildIndicator(),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: 125, minHeight: 50),
                          child: TextButton(
                              onPressed: controller.next,
                              child: Text(
                                controller.textButton,
                                style: TextStyle(fontSize: 17),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: controller.bgColor.value,
                                  foregroundColor: controller.fgColor.value,
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          side: BorderSide(
                                              color: primaryColor))))),
                        )
                      ],
                    ),
                  ],
                ))));
  }

  Widget buildImage(
          String urlImage, String textBelowImage, String note, int index) =>
      Container(
          padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(textBelowImage,
                              style: TextStyle(fontSize: 22)),
                        ),
                        Text(
                          note,
                          style: TextStyle(color: Colors.grey),
                        )
                      ]),
                )
              ]));

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        effect: SlideEffect(dotColor: color!, activeDotColor: primaryColor),
        activeIndex: controller.activeIndex.value,
        count: controller.urlImages.length);
  }
}
