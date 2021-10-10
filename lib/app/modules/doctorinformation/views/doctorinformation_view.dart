import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/controllers/doctorinformation_controller.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/views/reviews.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/views/updateview.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'constants.dart';

class DoctorinformationView extends GetView<DoctorinformationController> {
  @override
  Widget build(BuildContext context) {
    controller.loadData();
    controller.getReviewList();
    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.blue[100],
          child: Column(
            children: [
              buildPersionalView(),
              Expanded(
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: controller.flag
                          ? doctorInforUserViewMode(context)
                          : doctorInfo())),
            ],
          ),
        )));
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
                        if (!controller.isUpdate) {
                          Get.snackbar('Please update your information',
                              'To use other features please update your information');
                        } else {
                          Get.offAndToNamed(Routes.HOME_DOCTOR);
                        }
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
                child:
                    Text(controller.doctorName, style: TextStyle(fontSize: 20)),
              ),
              Text(
                controller.specialist,
                style: txtStyle,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 25, top: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RawMaterialButton(
                    onPressed: () {
                      controller.changeViewMode();
                    },
                    child: Icon(
                      controller.viewMode,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: bgColor,
                    padding: EdgeInsets.all(14),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      controller.makeHint();
                      Get.to(UpdateView());
                    },
                    child: Icon(
                      Icons.mode,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: bgColor,
                    padding: EdgeInsets.all(14),
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
                        controller.addressName,
                        style: textStyle,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          controller.doctorInfo.centeraddress!,
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
                                controller.doctorInfo.phone!,
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
  Widget buildRatingBar(BuildContext context) => Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text("Rating", style: textStyle),
            Icon(Icons.star, color: Colors.amber),
            Text(
              '(' + controller.doctorInfo.rating!.toStringAsFixed(1) + ')',
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
            initialRating: controller.doctorInfo.rating!,
            itemSize: 40,
            allowHalfRating: true,
            itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (double value) {},
          ),
        ),
      ]));

  Widget doctorInforUserViewMode(BuildContext context) {
    if (controller.doctorInfo.email == null) {
      return Container(
        key: Key('2'),
        decoration: detailStyle,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Container(
        key: Key('3'),
        decoration: detailStyle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          controller.doctorInfo.about!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: txtStyle,
                        ),
                      ),
                    ]),
              ),
            ),
            Reviews(
                size: MediaQuery.of(context).size,
                docId: controller.doctorId,
                controller: controller),
            buildRatingBar(context),
            buildLocationView(),
          ],
        ),
      );
    }
  }

  Widget doctorInfo() => Container(
        key: Key('1'),
        decoration: detailStyle,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Your information',
                style: textStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Email: '),
                          )
                        ],
                      ),
                    ),
                    Text(
                      controller.email!,
                      style: textStyle,
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Phone: '),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.doctorInfo.phone!,
                    style: textStyle,
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Address: '),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.addressName,
                    style: textStyle,
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.home_work,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Center address: '),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.doctorInfo.centeraddress!,
                    style: textStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.app_registration_rounded,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('About me: '),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.doctorInfo.about!,
                    style: textStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      );
}
