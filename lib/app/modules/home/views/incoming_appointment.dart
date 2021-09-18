import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/views/components/appointment_cart.dart';

class IncomingAppointment extends StatelessWidget {
  const IncomingAppointment({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
                      //
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
        Container(
          margin: EdgeInsets.only(top: 40),
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              AppointmentCard(
                image: 'assets/images/tooth.png',
                name: 'Tooth',
                drCount: '10 Doctors',
              ),
              AppointmentCard(
                image: 'assets/images/brain.png',
                name: 'Brain',
                drCount: '10 Doctors',
              ),
              AppointmentCard(
                image: 'assets/images/bone.png',
                name: 'Bone',
                drCount: '10 Doctors',
              ),
              AppointmentCard(
                image: 'assets/images/heart.png',
                name: 'Heart',
                drCount: '10 Doctors',
              ),
              AppointmentCard(
                image: 'assets/images/heart.png',
                name: 'Heart',
                drCount: '10 Doctors',
              ),
              AppointmentCard(
                image: 'assets/images/heart.png',
                name: 'Heart',
                drCount: '10 Doctors',
              ),
              AppointmentCard(
                image: 'assets/images/heart.png',
                name: 'Heart',
                drCount: '10 Doctors',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
