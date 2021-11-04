import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/dialog.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/controllers/schedule_doctor_controller.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/components/timeline_card.dart';
import 'package:get/get.dart';

class TimeLineList extends StatelessWidget {
  TimeLineList({Key? key}) : super(key: key);

  final ScheduleDoctorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                child: Text(
                  "Giờ khám của bạn",
                  style: TextStyle(
                    color: Color(0xff016565),
                    fontSize: 18,
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
                      DialogHelper.showDialog(
                        title: "Xác nhận",
                        content:
                            'Bạn có muốn xoá tất cả lịch trình trong ngày này?',
                        confirmText: 'Xoá tất cả',
                        onConfirm: () {
                          controller.deleteTimeLine();
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Xoá tất cả",
                        style: TextStyle(
                          color: Colors.red,
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
        Obx(() {
          if (controller.loading) {
            return Container(
              margin: EdgeInsets.only(top: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 600, minHeight: 100.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: controller.timeSlotList.length - 1,
                itemBuilder: (_, index) {
                  if (controller.deleteSlotList.contains(index))
                    return SizedBox.shrink();
                  return TimeLineCard(
                    timeStart: DateTimeHelpers.dateTimeToTime(
                        controller.timeSlotList[index]),
                    timeFinish: DateTimeHelpers.dateTimeToTime(controller
                        .timeSlotList[index]
                        .add(controller.restTime)),
                    onPressed: () {
                      DialogHelper.showDialog(
                        content: 'Bạn có muốn xoá khung giờ này?',
                        confirmText: 'Xoá',
                        onConfirm: () {
                          controller.deleteTimeSlot(index);
                        },
                      );
                      // controller.deleteTimeSlot(index);
                    },
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
