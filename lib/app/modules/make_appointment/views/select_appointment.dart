import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_loader.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/dialog.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/controllers/make_appointment_controller.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/calendar_list.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/components/time_select_button.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/constant.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(left: 20, right: 20),
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
                      "Chọn ngày",
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
                            "Tháng " + controller.selectedDate.month.toString(),
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
                      "Chọn giờ",
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
                    return LoadingScreen(height: height);
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
                      DateTime _timeSlot =
                          controller.timeSlotList[index]['time'];
                      bool isValid = controller.timeSlotList[index]['valid'];
                      Color backgroundColor = Colors.white;
                      Color textColor = Color(0xff545454);
                      Color borderColor = Color(0xffB0B0B0);
                      if (index == controller.selectedTime) {
                        backgroundColor = Color(0xff197D84);
                        textColor = Colors.white;
                        borderColor = Color(0xff197D84);
                      }
                      if (!isValid || DateTimeHelpers.isBeforeNow(_timeSlot)) {
                        backgroundColor = Color(0xffD6D6D6);
                        textColor = Color(0xff747474);
                        borderColor = Color(0xffD6D6D6);
                      }
                      return TimeSelectButton(
                        height: height * 0.1,
                        time: DateTimeHelpers.dateTimeToTime(
                            controller.timeSlotList[index]['time']),
                        textColor: textColor,
                        borderColor: borderColor,
                        backgroundColor: backgroundColor,
                        onPressed: () {
                          if (!isValid ||
                              DateTimeHelpers.isBeforeNow(_timeSlot)) return;
                          controller.onTimeChange(index);
                        },
                      );
                    }),
                  );
                }),
              ),
            ),
            CustomButton(
              text: "Đặt lịch hẹn",
              width: width * 0.8,
              height: 43,
              onPressed: () {
                if (controller.selectedTime == -1) {
                  Get.snackbar(
                    "Đặt lịch",
                    "Vui lòng chọn khung giờ còn trống.",
                  );
                  return;
                }
                DialogHelper.showDialog(
                  title: "Xác nhận đặt lịch?",
                  content: 'Lịch hẹn sẽ được đặt theo thời gian bạn đã chọn,',
                  confirmText: 'Đồng ý',
                  onConfirm: () async {
                    bool checkBooking = await controller.bookAppointment();
                    if (checkBooking) {
                      controller.createSchedule();
                      Get.toNamed(Routes.BOOKED_SUCCESS);
                    } else {
                      Get.snackbar(
                        "Đặt lịch",
                        "Đặt lịch lỗi do bị trùng giờ đặt với người khác.",
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
