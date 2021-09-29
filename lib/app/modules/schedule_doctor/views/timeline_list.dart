import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/controllers/schedule_doctor_controller.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/components/timeline_card.dart';
import 'package:get/get.dart';

class TimeLineList extends StatelessWidget {
  TimeLineList({Key? key}) : super(key: key);

  final ScheduleDoctorController controller = Get.find();

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
          style: TextStyle(color: Colors.red),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Cancel'),
      ),
      titlePadding: EdgeInsets.only(top: 15, bottom: 15),
      title: 'Confirmation',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      radius: 14,
      middleText: content ?? "Do you want?",
    );
  }

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
                  "Your schedule",
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
                      showDialog(
                        content: 'Do you want to delete all?',
                        confirmText: 'Delete',
                        onConfirm: () {
                          controller.deleteTimeLine();
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Delete All",
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
                    timeFinish: DateTimeHelpers.dateTimeToTime(
                        controller.timeSlotList[index + 1]),
                    onPressed: () {
                      showDialog(
                        content: 'Do you want to delete?',
                        confirmText: 'Delete',
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
