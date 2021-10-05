import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/calendar_list.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/make_schedule_form.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/timeline_list.dart';

import 'package:get/get.dart';

import '../controllers/schedule_doctor_controller.dart';

class ScheduleDoctorView extends GetView<ScheduleDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule of doctor'),
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
                    height: 90,
                    date: controller.selectedDate,
                    onChange: controller.onDateChange,
                  ),
                ),
                controller.timeSlotList.length <= 1
                    ? MakeScheduleForm()
                    : TimeLineList(),
                // ,
              ],
            ),
          );
        }),
      ),
    );
  }
}
