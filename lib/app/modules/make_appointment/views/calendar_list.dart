import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/controllers/make_appointment_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarList extends StatelessWidget {
  //
  final double? height;
  final DateTime? date;
  final void Function(DateTime)? onChange;

  CalendarList({this.height, this.date, this.onChange});

  final MakeAppointmentController controller = Get.find();

  final int noOfDates = 30;

  final DateFormat dFormat = new DateFormat("MMM");

  Widget _eachCalDate(index, context) {
    var thisDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: index));

    Color colorBackground = Color(0xffF2F5F2);
    Color textColor = Color(0xff8F8F8F);
    if (controller.isDate(thisDate, controller.selectedDate)) {
      colorBackground = Color(0xFF197D84);
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: () {
        this.onChange!(thisDate);
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 12.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: controller.isNow(thisDate)
                  ? Color(0xFF197D84)
                  : colorBackground),
          color: colorBackground,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              DateFormat('EEE').format(thisDate),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              thisDate.day.toString(),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
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