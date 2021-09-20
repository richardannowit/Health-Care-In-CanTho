import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/components/appointnent_card.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/appointments_controller.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('AppointmentsView'),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.offAllNamed(Routes.HOME);
                })),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: buildList(context),
        ));
  }

  Widget buildList(BuildContext context) {
    Query<Map<String, dynamic>> appointments = FirebaseFirestore.instance
        .collection('appointments')
        .where('emailpatient', isEqualTo: controller.userEmail);

    return StreamBuilder<QuerySnapshot>(
      stream: appointments.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        controller.getAppointments();
        return Obx(() => new ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return AppointmentCard(
                  image: 'assets/images/tooth.png',
                  name: 'Tooth',
                  drCount: '10 Doctors',
                  appointment: controller.appointmentList[index],
                );
              },
              itemCount: controller.appointmentList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.black,
                );
              },
            ));
      },
    );
  }
}
