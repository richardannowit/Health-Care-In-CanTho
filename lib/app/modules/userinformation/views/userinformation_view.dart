import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_appbar.dart';
import 'package:flutter_healthcare/app/modules/userinformation/views/constants.dart';
import 'package:flutter_healthcare/app/modules/userinformation/views/update_userinformation.dart';

import 'package:get/get.dart';

import '../controllers/userinformation_controller.dart';

class UserinformationView extends GetView<UserinformationController> {
  @override
  Widget build(BuildContext context) {
    controller.loadData();
    return Obx(() => Scaffold(
        body: Center(
            child: Stack(children: [
          Background(height: MediaQuery.of(context).size.height),
          Column(
            children: [
              CustomAppBar(title: ''),
              Flexible(
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: controller.loading
                        ? buildLoading()
                        : buildView(context)),
              ),
            ],
          ),
        ])),
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.to(UpdateUserInformationView());
            },
            label: Icon(Icons.mode),
            backgroundColor: primaryColor,
          ),
        )));
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
  Widget buildView(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20, bottom: 20),
                        width: 112,
                        height: 112,
                        child: CircleAvatar(
                          child: Image(
                            image: AssetImage('assets/images/avt_doctor.png'),
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width - 180,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.userInfo.email ?? "",
                              style: informationText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              controller.infor,
                              style: TextStyle(
                                color: Colors.grey[650],
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    controller.userName,
                    style: nameText,
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông Tin',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Ngày sinh',
                        style: keyText,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          controller.dateOfBirth,
                          style: informationText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 29),
                        child: Text(
                          'Địa chỉ',
                          style: keyText,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          controller.addressName,
                          style: informationText,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 57),
                        child: Text(
                          'SĐT',
                          style: keyText,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          controller.userInfo.phone ?? "",
                          style: informationText,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
}
