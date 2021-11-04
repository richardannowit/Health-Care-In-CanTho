import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_appbar.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/Header.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/select_appointment.dart';

import 'package:get/get.dart';

import '../controllers/make_appointment_controller.dart';

class MakeAppointmentView extends GetView<MakeAppointmentController> {
  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    var appbarHeight = AppBar().preferredSize.height;
    var screenHeight =
        MediaQuery.of(context).size.height - safePadding - appbarHeight;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Đặt lịch hẹn",
      ),
      body: Stack(
        children: [
          Background(height: MediaQuery.of(context).size.height),
          Container(
            child: Column(
              children: [
                Header(
                  height: screenHeight * 0.25,
                  name: controller.doctorProfile.name!,
                  specialist: controller.doctorProfile.specialist!,
                ),
                SelectAppointment(
                    height: screenHeight * 0.75, width: screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
