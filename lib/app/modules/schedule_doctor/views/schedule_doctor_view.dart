import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/calendar_list.dart';

import 'package:get/get.dart';

import '../controllers/schedule_doctor_controller.dart';

class ScheduleDoctorView extends GetView<ScheduleDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScheduleDoctorView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Container(
            child: Column(
              children: [
                CalendarList(
                  height: 80,
                  date: controller.selectedDate,
                  onChange: controller.onDateChange,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
