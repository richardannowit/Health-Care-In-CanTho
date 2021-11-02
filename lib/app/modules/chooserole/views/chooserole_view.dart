import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/modules/chooserole/views/constant.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/chooserole_controller.dart';

class ChooseroleView extends GetView<ChooseroleController> {
  @override
  Widget build(BuildContext context) {
    controller.loadData();
    return Scaffold(
        body: Obx(() => Stack(
              children: [
                Background(height: MediaQuery.of(context).size.height),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                            image: AssetImage(
                                'assets/images/first_start_icon.png'),
                            width: 186,
                            height: 100),
                        Container(
                          height: 380,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Bạn là bệnh nhân hay là bác sĩ?',
                                  style: styleOfQuestion),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: controller.doctorCardBoder.value,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 7),
                                        blurRadius: 20,
                                        color: Colors.grey.withOpacity(0.23),
                                      ),
                                    ],
                                  ),
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 140,
                                  child: CarouselSlider.builder(
                                    carouselController:
                                        controller.carouselControllerDoctor,
                                    options: CarouselOptions(
                                        autoPlay: controller.autoDoctor,
                                        viewportFraction: 1,
                                        initialPage: 0,
                                        enableInfiniteScroll: false,
                                        onPageChanged: (index, reason) {
                                          controller.activeIndex.value = index;
                                          if (index == 1)
                                            controller.autoDoctor = true;
                                          else
                                            controller.autoDoctor = false;
                                        }),
                                    itemCount: 2,
                                    itemBuilder: (context, index, realIndex) {
                                      return doctorCard(index);
                                    },
                                  ),
                                ),
                                onTap: () {
                                  controller.chooseDoctor();
                                  controller.carouselControllerDoctor
                                      .nextPage();
                                  controller.bgColor.value =
                                      MaterialStateProperty.all<Color>(
                                          primaryColor);
                                  controller.fgColor.value =
                                      MaterialStateProperty.all<Color>(
                                          Colors.white);
                                  controller.doctorCardBoder.value =
                                      Border.all(color: primaryColor, width: 3);
                                  controller.patientCardBoder.value =
                                      Border.all(color: Colors.white, width: 0);
                                },
                              ),
                              InkWell(
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: controller.patientCardBoder.value,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(13)),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 7),
                                          blurRadius: 20,
                                          color: Colors.grey.withOpacity(0.23),
                                        ),
                                      ],
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    height: 140,
                                    child: CarouselSlider.builder(
                                      carouselController:
                                          controller.carouselControllerPatient,
                                      options: CarouselOptions(
                                          autoPlay: controller.autoPatient,
                                          viewportFraction: 1,
                                          initialPage: 0,
                                          enableInfiniteScroll: false,
                                          onPageChanged: (index, reason) {
                                            controller.activeIndex.value =
                                                index;
                                            if (index == 1)
                                              controller.autoPatient = true;
                                            else
                                              controller.autoPatient = false;
                                          }),
                                      itemCount: 2,
                                      itemBuilder: (context, index, realIndex) {
                                        return patientCard(index);
                                      },
                                    )),
                                onTap: () {
                                  controller.choosePatient();
                                  controller.carouselControllerPatient
                                      .nextPage();
                                  controller.bgColor.value =
                                      MaterialStateProperty.all<Color>(
                                          primaryColor);
                                  controller.fgColor.value =
                                      MaterialStateProperty.all<Color>(
                                          Colors.white);
                                  controller.doctorCardBoder.value =
                                      Border.all(color: Colors.white, width: 0);
                                  controller.patientCardBoder.value =
                                      Border.all(color: primaryColor, width: 3);
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 74,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 110,
                                height: 45,
                                child: TextButton(
                                  onPressed: () async {
                                    if (controller.isChoosed) {
                                      if (controller.isDoctor) {
                                        await controller
                                            .transInformation('doctors');
                                        Get.offAllNamed(
                                            Routes.DOCTORINFORMATION,
                                            arguments: "isFirst");
                                      } else {
                                        await controller
                                            .transInformation('users');
                                        Get.offAllNamed(Routes.USERINFORMATION,
                                            arguments: "isFirst");
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Bắt đầu',
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'Roboto'),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: controller.bgColor.value,
                                    foregroundColor: controller.fgColor.value,
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          side:
                                              BorderSide(color: primaryColor)),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Bắt đầu nhập thông tin của bạn',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            )));
  }

  Widget doctorCard(int index) {
    if (index == 1)
      return Container(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/bookapp.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Đặt lịch hẹn với bệnh nhân',
                      style: normalText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/message.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Nhắn tin với bệnh nhân',
                      style: normalText,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/timemana.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Hỗ trợ sắp xếp lịch cho công việc',
                      style: normalText,
                    ),
                  )
                ],
              ),
            ],
          ));

    return Obx(() => Container(
          child: Row(
            children: [
              Container(
                height: 140,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image(
                      image: AssetImage('assets/images/doctor.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Container(
                  height: 140,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Bác sĩ',
                        style: styleOfTitle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/bookapp.jpg'),
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/message.jpg'),
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/timemana.jpg'),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              controller.doctorRate,
                              style: normalText,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            height: 10,
                            child: LinearProgressIndicator(
                              value: controller.doctorPercent,
                              valueColor: AlwaysStoppedAnimation(fgColorOfRate),
                              backgroundColor: bgColorOfRate,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget patientCard(int index) {
    if (index == 1) {
      return Container(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/bookapp.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Đặt lịch hẹn với bác sĩ',
                      style: normalText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/message.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Nhắn tin với bác sĩ',
                      style: normalText,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/review.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Đánh giá và xem đánh giá về bác sĩ',
                      style: normalText,
                    ),
                  )
                ],
              ),
            ],
          ));
    }
    return Obx(() => Container(
          child: Row(
            children: [
              Container(
                height: 140,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image(
                    image: AssetImage('assets/images/patient.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 140,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Bệnh nhân',
                        style: styleOfTitle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/bookapp.jpg'),
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/message.jpg'),
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/review.jpg'),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              controller.patientRate,
                              style: normalText,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            height: 10,
                            child: LinearProgressIndicator(
                              value: controller.patientPercent,
                              valueColor: AlwaysStoppedAnimation(fgColorOfRate),
                              backgroundColor: bgColorOfRate,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
