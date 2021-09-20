import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_healthcare/app/modules/home/views/components/appointment_cart.dart';
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
                    onTap: () {},
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
        FutureBuilder(
          future: DatabaseMethods.getAppointments(controller.user!.email!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var appointmentList = snapshot.data as List<AppointmentModel>;
            print(appointmentList);
            if (appointmentList.length == 0) {
              return Container(
                margin: EdgeInsets.only(top: 30),
                height: size.height * 0.22,
                child: Text("No appointment yet"),
              );
            }
            return Container(
              margin: EdgeInsets.only(top: 30),
              height: size.height * 0.22,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: appointmentList.length,
                itemBuilder: (_, index) {
                  return AppointmentCard(
                    doctor_image: 'assets/images/avt_doctor.png',
                    doctor_name: appointmentList[index].doctor!.name,
                    specialist: appointmentList[index].doctor!.specialist,
                    date: DateTimeHelpers.timestampsToDate(
                        appointmentList[index].appointment_date!),
                    time: "10:30 AM",
                    status: "Active",
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
