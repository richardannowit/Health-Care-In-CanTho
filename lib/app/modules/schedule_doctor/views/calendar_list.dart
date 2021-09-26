import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/controllers/schedule_doctor_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarList extends StatelessWidget {
  //
  final double? height;
  final DateTime? date;
  final void Function(DateTime)? onChange;

  CalendarList({this.height, this.date, this.onChange});

  final ScheduleDoctorController controller = Get.find();

  final int noOfDates = 30;

  final DateFormat dFormat = new DateFormat("MMM");

  Widget _eachCalDate(index, context) {
    var thisDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).subtract(Duration(days: 2)).add(Duration(days: index));

    return Obx(() {
      return GestureDetector(
        onTap: () {
          this.onChange!(thisDate);
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 12.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: controller.isDate(thisDate, controller.selectedDate)
                    ? Color(0xFF197D84)
                    : Color(0xFFE3E3E3)),
            color: Color(0xFFE3E3E3),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Column(
            children: <Widget>[
              Text(
                DateFormat('EEE').format(thisDate),
                style: TextStyle(
                  color: controller.isDate(thisDate, controller.selectedDate)
                      ? Color(0xFF197D84)
                      : Color(0xFF696969),
                ),
              ),
              Text(
                thisDate.day.toString(),
                style: TextStyle(
                  color: controller.isDate(thisDate, controller.selectedDate)
                      ? Color(0xFF197D84)
                      : Color(0xFF696969),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          maxHeight: height!,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // reverse: true,
          shrinkWrap: true,
          itemCount: noOfDates,
          itemBuilder: (context, index) => _eachCalDate(index, context),
        ),
      ),
    );
  }
}



// Text(dFormat.format(thisDate),
//                 style: TextStyle(color: Color(0xFF696969))),