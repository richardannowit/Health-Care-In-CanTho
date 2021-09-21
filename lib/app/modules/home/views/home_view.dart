import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';
import 'package:flutter_healthcare/app/modules/home/views/doctors_list.dart';
import 'package:flutter_healthcare/app/modules/home/views/incoming_appointment.dart';
import 'package:flutter_healthcare/app/modules/home/views/infomation.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: RefreshIndicator(
          onRefresh: () => controller.loadData(),
          child: SingleChildScrollView(
            child: Obx(() {
              if (controller.loading == true) {
                return Container(
                  height: size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                width: size.width,
                // decoration: BoxDecoration(
                //   color: Colors.grey[100],
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfomationUser(
                      size: size,
                      name: controller.userInfo.name!,
                      bmi: controller.bmi.value,
                    ),
                    IncomingAppointment(size: size),
                    DoctorsList(
                      size: size,
                      user: controller.userInfo,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
