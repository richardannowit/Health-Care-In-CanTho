import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_loader.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/controllers/schedule_doctor_controller.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/components/button.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/components/timepicker.dart';
import 'package:get/get.dart';

class MakeScheduleForm extends StatelessWidget {
  MakeScheduleForm({Key? key}) : super(key: key);

  final ScheduleDoctorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Center(
                child: Container(
                  child: Text(
                    "Lập lịch trình",
                    style: TextStyle(
                      color: Color(0xff016565),
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
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
                        "",
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
        Obx(() {
          if (controller.loading) {
            return LoadingScreen(height: size.height * 0.7);
          }
          return Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimePicker(
                    label: "Thời gian bắt đầu",
                    selectedTime:
                        '${controller.timeStart.hour.toString().padLeft(2, '0')}:${controller.timeStart.minute.toString().padLeft(2, '0')}',
                    onPress: () async {
                      controller.timeStart = await controller.showSelectedTime(
                          context, controller.timeStart);
                    },
                  ),
                  TimePicker(
                    label: "Thời gian kết thúc",
                    selectedTime:
                        '${controller.timeFinish.hour.toString().padLeft(2, '0')}:${controller.timeFinish.minute.toString().padLeft(2, '0')}',
                    onPress: () async {
                      controller.timeFinish = await controller.showSelectedTime(
                          context, controller.timeFinish);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimePicker(
                    label: "Thời gian nghĩ ngơi",
                    selectedTime:
                        '${controller.timeRelaxStart.hour.toString().padLeft(2, '0')}:${controller.timeRelaxStart.minute.toString().padLeft(2, '0')}',
                    onPress: () async {
                      controller.timeRelaxStart = await controller
                          .showSelectedTime(context, controller.timeRelaxStart);
                    },
                  ),
                  TimePicker(
                    label: "",
                    selectedTime:
                        '${controller.timeRelaxFinish.hour.toString().padLeft(2, '0')}:${controller.timeRelaxFinish.minute.toString().padLeft(2, '0')}',
                    onPress: () async {
                      controller.timeRelaxFinish =
                          await controller.showSelectedTime(
                              context, controller.timeRelaxFinish);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimePicker(
                    label: "Thời gian khám mỗi bệnh nhân",
                    selectedTime:
                        '${controller.duration.hour.toString().padLeft(2, '0')}:${controller.duration.minute.toString().padLeft(2, '0')}',
                    onPress: () async {
                      controller.duration = await controller.showSelectedTime(
                          context, controller.duration);
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: CustomButton(
                  height: 50,
                  width: size.width / 1.5,
                  text: "Xong",
                  onPressed: () {
                    controller.makeSchedule();
                  },
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
