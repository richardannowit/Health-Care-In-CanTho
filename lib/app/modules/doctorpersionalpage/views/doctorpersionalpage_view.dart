import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/data/notifications/notifications.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/views/component/ratingdialog.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/views/constants.dart';

import 'package:flutter_healthcare/app/modules/doctorpersionalpage/views/reviews.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import '../controllers/doctorpersionalpage_controller.dart';

class DoctorpersionalpageView extends GetView<DoctorpersionalpageController> {
  DoctorpersionalpageView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getReviewList();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
          height: 50,
          width: 180,
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.toNamed(Routes.MAKE_APPOINTMENT,
                  arguments: controller.doctor);
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.calendar_today_sharp),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Đặt lịch hẹn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: primaryColor,
          )),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Background(height: MediaQuery.of(context).size.height),
          Column(
            children: [
              buildPersionalView(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          //color: Colors.blue[50],
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Giới thiệu', style: textStyle),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      controller.doctor.about!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: txtStyle,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Reviews(
                          controller: controller,
                          size: size,
                          docId: controller.doctor.docId!,
                        ),
                        buildRatingBar(context),
                        buildLocationView(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPersionalView() => Container(
        padding: EdgeInsets.fromLTRB(0, 26, 0, 0),
        //  color: Colors.red[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.offNamed(Routes.DOCTORPERSIONALPAGE);
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: primaryColor,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: primaryColor,
                      ))
                ],
              ),
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/images/avt_doctor.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(controller.doctor.name!, style: nameText),
              ),
              Text(
                controller.doctor.specialist!,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RawMaterialButton(
                    onPressed: () {
                      makeNotification();
                    },
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: primaryColor,
                    padding: EdgeInsets.all(12),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      cancelScheduledNotifications();
                    },
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: primaryColor,
                    padding: EdgeInsets.all(12),
                  ),
                ]),
              ),
            ],
          ),
        ),
      );
  Widget buildLocationView() => Container(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Địa chỉ',
                style: textStyle,
              ),
            ),
            Row(
              children: [
                Container(
                    width: 54,
                    height: 54,
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 54,
                      color: primaryColor,
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.doctor.address.name,
                          style: textStyle,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            controller.doctor.centeraddress!,
                            style: txtStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 16,
                                color: primaryColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  controller.doctor.phone!,
                                  style: txtStyle,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
  Widget buildRatingBar(BuildContext context) => Obx(() => Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text("Đánh giá", style: textStyle),
            Icon(Icons.star, color: Colors.amber),
            Text(
              '(' + controller.txRating.toStringAsFixed(1) + ')',
              style: txtStyle,
            ),
            Text(
              '(' + controller.reviewList.length.toString() + ')',
              style: txtStyle,
            ),
          ],
        ),
        Center(
          child: RatingBar.builder(
            initialRating: controller.rxRating,
            itemSize: 40,
            allowHalfRating: true,
            itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              controller.rxRating = rating;
              controller.score = rating;
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return RatingDialog(
                      rating: rating,
                      controller: controller,
                    );
                  });
            },
          ),
        ),
      ])));
}
