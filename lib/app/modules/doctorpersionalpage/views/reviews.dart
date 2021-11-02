import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/controllers/doctorpersionalpage_controller.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/views/component/reviewcard.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/views/constants.dart';
import 'package:get/get.dart';

class Reviews extends StatelessWidget {
  Reviews(
      {Key? key,
      required this.size,
      required this.docId,
      required this.controller})
      : super(key: key);
  final DoctorpersionalpageController controller;
  final Size size;
  final String docId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                child: Text("Nhận xét", style: textStyle),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.loading) return buildProgressIndicator(context);
          if (controller.reviewList.isEmpty) return buildNullCard(context);
          return Container(
            height: 152,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.width + 50,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  onPageChanged: (index, reason) {}),
              itemCount: controller.reviewList.length,
              itemBuilder: (context, index, realIndex) {
                return ReviewCard(
                  size: size,
                  content: controller.reviewList[index].content,
                  score: controller.reviewList[index].score,
                  date: DateTimeHelpers.timestampsToDate(
                      controller.reviewList[index].date!),
                  name: controller.reviewList[index].userName,
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildProgressIndicator(BuildContext context) {
    return Container(
        height: 152,
        padding: EdgeInsets.all(10),
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }

  Widget buildNullCard(BuildContext context) {
    return Container(
        height: 152,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hiện tại chưa có nhận xét nào!!',
              style: textStyle,
            ),
          ],
        ));
  }
}
