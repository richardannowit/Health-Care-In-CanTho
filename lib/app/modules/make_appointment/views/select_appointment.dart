import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/controllers/make_appointment_controller.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/calendar_list.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/components/custom_button.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/components/time_select_button.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/constant.dart';
import 'package:get/get.dart';

class SelectAppointment extends StatelessWidget {
  SelectAppointment({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  final MakeAppointmentController controller = Get.find();

  showDialog(
      {String? content, String? confirmText, void Function()? onConfirm}) {
    Get.defaultDialog(
      confirm: TextButton(
        onPressed: () {
          onConfirm!();
          Get.back();
        },
        child: Text(
          confirmText ?? 'Confirm',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      cancel: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.grey,
        ),
        onPressed: () {
          Get.back();
        },
        child: Text('Cancel'),
      ),
      titlePadding: EdgeInsets.only(top: 15, bottom: 15),
      title: 'Confirmation',
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue,
      radius: 14,
      middleText: content ?? "Do you want?",
    );
  }

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
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 5),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Text(
                      "Time",
                      style: TextStyle(
                        color: Color(0xff016565),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Obx(() {
                  if (controller.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.timeSlotList.length == 0) {
                    return Center(child: Text('Bác sĩ bận rồi :('));
                  }
                  return GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: List.generate(controller.timeSlotList.length - 1,
                        (index) {
                      Color backgroundColor = Colors.white;
                      Color textColor = Color(0xff545454);
                      Color borderColor = Color(0xffB0B0B0);
                      if (index == controller.selectedTime) {
                        backgroundColor = Color(0xff197D84);
                        textColor = Colors.white;
                        borderColor = Color(0xff197D84);
                      }
                      return TimeSelectButton(
                        height: height * 0.1,
                        time: DateTimeHelpers.dateTimeToTime(
                            controller.timeSlotList[index]['time']),
                        textColor: textColor,
                        borderColor: borderColor,
                        backgroundColor: backgroundColor,
                        onPressed: () {
                          controller.onTimeChange(index);
                        },
                      );
                    }),
                  );
                }),
              ),
            ),
            CustomButton(
              width: width * 0.5,
              height: 40,
              onPressed: () {
                //Check chon ngay gio r moi submit duoc
                showDialog(
                  content: 'Do you want to booking?',
                  confirmText: 'Confirm',
                  onConfirm: () async {
                    bool checkBooking = await controller.bookAppointment();
                    if (checkBooking) {
                      Get.snackbar(
                        "Booking",
                        "Booking successfull.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      Get.snackbar(
                        "Booking",
                        "Booking fail cause conflict with others.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
