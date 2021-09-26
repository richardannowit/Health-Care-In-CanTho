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
                child: Text("Review", style: textStyle),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.loading) return buildProgressIndicator(context);
          if (controller.reviewList.isEmpty) return buildNullCard(context);
          return Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: Colors.white,
            height: size.height * 0.19,
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              itemCount: controller.reviewList.length,
              itemBuilder: (_, index) {
                return ReviewCard(
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
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: Colors.white,
        height: size.height * 0.19,
        padding: EdgeInsets.all(10),
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }

  Widget buildNullCard(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: Colors.white,
        height: size.height * 0.19,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No review yet!!',
              style: textStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Be the first to review ' + controller.doctor.name!,
                style: txtStyle,
              ),
            )
          ],
        ));
  }
}
