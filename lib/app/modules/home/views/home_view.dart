import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/views/doctors_list.dart';
import 'package:flutter_healthcare/app/modules/home/views/incoming_appointment.dart';
import 'package:flutter_healthcare/app/modules/home/views/infomation.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20),
          width: size.width,
          // decoration: BoxDecoration(
          //   color: Colors.grey[100],
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return InfomationUser(
                  size: size,
                  name: controller.user!.displayName!,
                  bmi: controller.bmi.value,
                );
              }),
              IncomingAppointment(size: size),
              DoctorsList(size: size),
            ],
          ),
        ),
      ),
    );
  }
}
