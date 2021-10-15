import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/controllers/make_appointment_controller.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/calendar_list.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/constant.dart';
import 'package:get/get.dart';

class SelectAppointment extends StatelessWidget {
  SelectAppointment({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  final MakeAppointmentController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: roundedContainer,
      padding: EdgeInsets.all(20),
      child: Obx(() {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 5),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Text(
                      "Date",
                      style: TextStyle(
                        color: Color(0xff016565),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          //
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "April",
                            style: TextStyle(
                              color: Color(0xff443BAD),
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CalendarList(
              height: height * 0.15,
              date: controller.selectedDate,
              onChange: controller.onDateChange,
            ),
          ],
        );
      }),
    );
  }
}
