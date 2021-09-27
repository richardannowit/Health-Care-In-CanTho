import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/calendar_list.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/make_schedule_form.dart';

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
      // backgroundColor: Color(0xffFFF9F6),
      body: SingleChildScrollView(
        child: Obx(() {
          return Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: CalendarList(
                    height: 80,
                    date: controller.selectedDate,
                    onChange: controller.onDateChange,
                  ),
                ),
                // TimeLineList(),
                MakeScheduleForm(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
