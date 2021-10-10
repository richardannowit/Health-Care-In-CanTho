import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_doctor_controller.dart';

class HomeDoctorView extends GetView<HomeDoctorController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Obx(() {
            if (controller.loading) {
              return CircularProgressIndicator();
            }
            return Column(
              children: [
                Text(
                  'Hi, I am a doctor, My name is ' +
                      controller.doctorProfile.name!,
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.SCHEDULE_DOCTOR,
                        arguments: controller.doctorProfile);
                  },
                  child: Text('Make Schedules'),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.DOCTORINFORMATION);
                  },
                  child: Text('Information'),
                ),
                TextButton(
                  onPressed: () {
                    controller.signOut();
                  },
                  child: Text('Log out'),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
