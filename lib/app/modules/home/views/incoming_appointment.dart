import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                child: Text(
                  "Incoming Appointment",
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
                      Get.toNamed(Routes.APPOINTMENTS);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xff016565),
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
          if (controller.appointmentList.length == 0) {
            return Container(
              margin: EdgeInsets.only(top: 30),
              child: Text("No appointment yet"),
            );
          }
          return Container(
            margin: EdgeInsets.only(top: 30),
            height: size.height * 0.22,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              itemCount: controller.appointmentList.length,
              itemBuilder: (_, index) {
                return AppointmentCard(
                  doctor_image: 'assets/images/avt_doctor.png',
                  doctor_name: controller.appointmentList[index].doctor!.name,
                  specialist:
                      controller.appointmentList[index].doctor!.specialist,
                  date: DateTimeHelpers.timestampsToDate(
                      controller.appointmentList[index].appointment_date!),
                  time: "10:30 AM",
                  status: "Active",
                );
              },
            ),
          );
        })
      ],
    );
  }
}
