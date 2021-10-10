import 'package:flutter/material.dart';
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
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.blue[100],
          child: Column(
            children: [
              buildPersionalView(),
              Expanded(
                child: Container(
                  decoration: detailStyle,
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
                                Text('About doctor', style: textStyle),
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
                      Container(
                        width: size.width * 0.6,
                        height: 40,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Book Appoinment',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blueAccent),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
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
                      icon: Icon(Icons.arrow_back_ios)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu))
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
                child: Text(controller.doctor.name!,
                    style: TextStyle(fontSize: 20)),
              ),
              Text(
                controller.doctor.specialist!,
                style: txtStyle,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RawMaterialButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: bgColor,
                    padding: EdgeInsets.all(12),
                  ),
                  RawMaterialButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: bgColor,
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
                'Location',
                style: textStyle,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: Icon(
                      Icons.location_on,
                      size: 27,
                    ),
                  ),
                ),
                Container(
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
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 16,
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
            Text("Rating", style: textStyle),
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
