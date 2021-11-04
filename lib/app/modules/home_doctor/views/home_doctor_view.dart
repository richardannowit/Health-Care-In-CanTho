import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/modules/home/views/constants.dart';
import 'package:flutter_healthcare/app/modules/home_doctor/views/incoming_appointment.dart';
import 'package:flutter_healthcare/app/modules/home_doctor/views/infomation.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_doctor_controller.dart';

class HomeDoctorView extends GetView<HomeDoctorController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: buildDrawer(context),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(Routes.SCHEDULE_DOCTOR,
                arguments: controller.doctorProfile);
          },
          label: const Text('Lập lịch'),
          icon: const Icon(Icons.calendar_today_rounded),
          backgroundColor: primaryColor,
        ),
        body: Stack(
          children: [
            Background(height: size.height),
            SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () => controller.loadData(),
                child: Obx(() {
                  if (controller.loading == true) {
                    return Container(
                      height: size.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfomationUser(
                          scaffoldKey: _scaffoldKey,
                          size: size,
                          name: controller.doctorProfile.name!,
                        ),
                        IncomingAppointment(size: size),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Drawer(
          child: Material(
            child: ListView(
              children: <Widget>[
                buildMenuItem(
                    text: 'Thông tin bác sĩ',
                    icon: Icons.person,
                    iconColor: Colors.blue,
                    onPressed: () {
                      Get.toNamed(Routes.DOCTORINFORMATION);
                    }),
                buildMenuItem(
                    text: 'Đăng xuất',
                    icon: Icons.logout,
                    iconColor: Colors.blue,
                    onPressed: () {
                      controller.signOut();
                    }),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required iconColor,
    required GestureTapCallback onPressed,
  }) {
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: largeTextStyle,
      ),
      hoverColor: hoverColor,
      onTap: onPressed,
    );
  }
}
