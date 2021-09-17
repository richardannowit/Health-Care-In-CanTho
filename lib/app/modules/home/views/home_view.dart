import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/views/components/doctors_card.dart';
import 'package:flutter_healthcare/app/modules/home/views/doctors_list.dart';
import 'package:flutter_healthcare/app/modules/home/views/incoming_appointment.dart';
import 'package:flutter_healthcare/app/modules/home/views/infomation.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'components/appointment_cart.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20),
          width: size.width,
          // decoration: BoxDecoration(
          //   color: Colors.grey[100],
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfomationUser(size: size),
              IncomingAppointment(size: size),
              Container(
                width: size.width,
                margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                      child: Text(
                        "Doctors List in your area",
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    DoctorCard(
                      img: 'assets/images/dr_1.png',
                      name: 'Dr. Fred Mask',
                      speciality: 'Heart surgen',
                      rating: '4.1',
                    ),
                    DoctorCard(
                      img: 'assets/images/dr_1.png',
                      name: 'Dr. Fred Mask',
                      speciality: 'Heart surgen',
                      rating: '4.1',
                    ),
                    DoctorCard(
                      img: 'assets/images/dr_1.png',
                      name: 'Dr. Fred Mask',
                      speciality: 'Heart surgen',
                      rating: '4.1',
                    ),
                    DoctorCard(
                      img: 'assets/images/dr_1.png',
                      name: 'Dr. Fred Mask',
                      speciality: 'Heart surgen',
                      rating: '4.1',
                    ),
                    DoctorCard(
                      img: 'assets/images/dr_1.png',
                      name: 'Dr. Fred Mask',
                      speciality: 'Heart surgen',
                      rating: '4.1',
                    ),
                    DoctorCard(
                      img: 'assets/images/dr_1.png',
                      name: 'Dr. Fred Mask',
                      speciality: 'Heart surgen',
                      rating: '4.1',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
