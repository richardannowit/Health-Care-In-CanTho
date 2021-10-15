import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/Header.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/calendar_list.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/constant.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/select_appointment.dart';

import 'package:get/get.dart';

import '../controllers/make_appointment_controller.dart';

class MakeAppointmentView extends GetView<MakeAppointmentController> {
  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    var screenHeight = MediaQuery.of(context).size.height - safePadding;
    return Scaffold(
      backgroundColor: Color(0xffE2FEEF),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Header(height: screenHeight * 0.3),
              SelectAppointment(height: screenHeight * 0.7),
            ],
          ),
        ),
      ),
    );
  }
}
