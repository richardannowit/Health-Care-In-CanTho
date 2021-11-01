import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_healthcare/app/modules/home/views/components/appointment_cart.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';

class IncomingAppointment extends StatelessWidget {
  IncomingAppointment({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  final HomeController controller = Get.find();
  showDialog(
      {String? content, String? confirmText, void Function()? onConfirm}) {
    Get.defaultDialog(
      confirm: TextButton(
        onPressed: () {
          onConfirm!();
          Get.back();
        },
        child: Text(
          confirmText ?? 'Đồng ý',
          style: TextStyle(color: Colors.red),
        ),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Huỷ bỏ'),
      ),
      titlePadding: EdgeInsets.only(top: 15, bottom: 15),
      title: 'Xác nhận',
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
                      Get.toNamed(Routes.APPOINTMENTS);
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
              margin: EdgeInsets.only(top: 30),
              child: Text("Bạn không có cuộc hẹn nào"),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: 20, left: 20),
            height: size.height * 0.18,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              itemCount: controller.appointmentList.length,
              itemBuilder: (_, index) {
                return AppointmentCard(
                  height: size.height * 0.18,
                  doctor_image: 'assets/images/avt_doctor.png',
                  doctor_name: controller.appointmentList[index].doctor!.name,
                  specialist:
                      controller.appointmentList[index].doctor!.specialist,
                  date: DateTimeHelpers.timestampsToDate(
                      controller.appointmentList[index].appointment_date!),
                  time: DateTimeHelpers.timestampsToTime(
                      controller.appointmentList[index].appointment_date!),
                  status: controller.appointmentList[index].status!,
                  onMessage: () {
                    //
                  },
                  onCancel: () {
                    showDialog(
                      content: 'Xác nhận huỷ lịch hẹn?',
                      confirmText: 'Xác nhận',
                      onConfirm: () {
                        controller.cancelAppointment(index);
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
