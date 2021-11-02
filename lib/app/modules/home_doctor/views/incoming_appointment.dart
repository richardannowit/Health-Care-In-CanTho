import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/data/helper/create_chatroom_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/dialog.dart';
import 'package:flutter_healthcare/app/modules/home_doctor/controllers/home_doctor_controller.dart';
import 'package:flutter_healthcare/app/modules/home_doctor/views/components/appointment_cart.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';

class IncomingAppointment extends StatelessWidget {
  IncomingAppointment({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  final HomeDoctorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          margin: EdgeInsets.only(top: 30, right: 20, left: 20),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                child: Text(
                  "Các cuộc hẹn sắp đến",
                  style: TextStyle(
                    color: Color(0xff5F6468),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPOINTMENTS_DOCTOR);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Xem thêm",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
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
          if (controller.appointmentList.length == 0) {
            return Container(
              height: size.height * 0.16,
              margin: EdgeInsets.only(top: 30),
              child: Center(child: Text("Bạn không có cuộc hẹn nào")),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: 20, left: 20),
            height: size.height * 0.65,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: controller.appointmentList.length,
              itemBuilder: (_, index) {
                return AppointmentCard(
                  height: size.height * 0.18,
                  doctor_image: 'assets/images/avt_doctor.png',
                  doctor_name:
                      controller.appointmentList[index].patientModel!.name,
                  date: DateTimeHelpers.timestampsToDate(
                      controller.appointmentList[index].appointment_date!),
                  time: DateTimeHelpers.timestampsToTime(
                      controller.appointmentList[index].appointment_date!),
                  status: controller.appointmentList[index].status!,
                  onMessage: () {
                    CreateChatRoom().createChatroomAndStartConversation(
                        controller.appointmentList[index].doctor!.email
                            .toString(),
                        controller.appointmentList[index].doctor!.name
                            .toString());
                  },
                  onCancel: () {
                    DialogHelper.showDialog(
                      content: 'Xác nhận huỷ lịch hẹn?',
                      confirmText: 'Xác nhận',
                      onConfirm: () {
                        // controller.cancelAppointment(index);
                      },
                    );
                  },
                );
              },
            ),
          );
        })
      ],
    );
  }
}
