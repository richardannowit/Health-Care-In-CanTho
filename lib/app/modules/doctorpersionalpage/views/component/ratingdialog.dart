import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/controllers/doctorpersionalpage_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../constants.dart';

class RatingDialog extends StatelessWidget {
  RatingDialog({Key? key, this.size, required this.controller, this.rating})
      : super(key: key);
  final Size? size;
  final double? rating;
  final DoctorpersionalpageController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                          child: Image(
                        image: AssetImage('assets/images/avt_doctor.png'),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('What do you think about me?',
                            style: textStyle),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Score',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                      RatingBar.builder(
                          itemSize: 40,
                          allowHalfRating: true,
                          initialRating: rating!,
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) {
                            controller.score = rating;
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    onChanged: (value) {
                      controller.content = value;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                          controller.changeRxRating();
                        },
                        child: Text('Back'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          if (controller.score == 0 ||
                              controller.content == '') {
                            Get.back();
                            Get.snackbar('Error!',
                                'Please make sure you have entered the correct review information');
                            controller.changeRxRating();
                          } else {
                            controller.upReview();
                            Get.back();
                            Get.snackbar('Success!',
                                'Thank you for your review, we will use it to improve our service quality!!');
                          }
                        },
                        child: Text('Send Review'),
                        style: reviewBtnStyle,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
