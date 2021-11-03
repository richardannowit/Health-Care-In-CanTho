import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/controllers/doctorinformation_controller.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/views/constants.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/views/reviews.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/views/updateview.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

class DoctorInformationView extends GetView<DoctorinformationController> {
  DoctorInformationView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.loadData();
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Background(height: MediaQuery.of(context).size.height),
              AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: controller.loading && controller.checkLoad
                      ? buildLoading()
                      : buildView(context)),
            ],
          ),
        ));
  }

  Widget buildLoading() =>
      Center(key: Key('3'), child: CircularProgressIndicator());

  Widget buildView(BuildContext context) => Column(
        children: [
          buildPersionalView(),
          Expanded(
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: controller.flag
                    ? buildDoctorViewMode(context)
                    : buildUserVewMode(context)),
          )
        ],
      );

  Widget buildDoctorViewMode(BuildContext context) => Container(
        key: Key('2'),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Email: ', style: textStyle),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.email!,
                    style: informationText,
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
                          Icons.phone,
                          color: primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Phone: ',
                            style: textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.doctorInfo.phone!,
                    style: informationText,
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
                          color: primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Address: ',
                            style: textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.addressName,
                    style: informationText,
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
                          color: primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Center address: ',
                            style: textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.doctorInfo.centeraddress!,
                    style: informationText,
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
                          color: primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'About me: ',
                            style: textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    controller.doctorInfo.about!,
                    style: informationText,
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
  Widget buildUserVewMode(BuildContext context) => Container(
        key: Key('1'),
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
                          controller.doctorInfo.about ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: txtStyle,
                        ),
                      ),
                    ]),
              ),
            ),
            Reviews(size: MediaQuery.of(context).size, controller: controller),
            buildRatingBar(context),
            buildLocationView(),
          ],
        ),
      );

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
                          Get.snackbar('Hãy cập nhật thông tin của bạn',
                              'Để sử dụng các tính năng khác thông tin của bạn là rất cần thiết');
                        } else {
                          Get.toNamed(Routes.HOME_DOCTOR);
                          Get.delete<DoctorinformationController>();
                        }
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
                child: Text(controller.doctorName, style: nameText),
              ),
              Text(
                controller.doctorInfo.specialist ?? "",
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
                      controller.changeViewMode();
                    },
                    child: Icon(
                      controller.viewMode,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: primaryColor,
                    padding: EdgeInsets.all(12),
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
                          controller.doctorInfo.centeraddress ?? "",
                          style: txtStyle,
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
                                controller.doctorInfo.phone ?? "",
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
            Text("Đánh giá", style: textStyle),
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
            initialRating: controller.doctorInfo.rating ?? 0,
            itemSize: 40,
            allowHalfRating: true,
            itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {},
          ),
        ),
      ])));
}
