import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/constants.dart';
import 'package:flutter_healthcare/app/modules/home/views/doctors_list.dart';
import 'package:flutter_healthcare/app/modules/home/views/incoming_appointment.dart';
import 'package:flutter_healthcare/app/modules/home/views/infomation.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: buildDrawer(context),
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
                          name: controller.userInfo.name!,
                          bmi: controller.bmi.value,
                        ),
                        IncomingAppointment(size: size),
                        DoctorsList(
                          size: size,
                          user: controller.userInfo,
                        ),
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
                    text: 'User information',
                    icon: Icons.person,
                    iconColor: Colors.blue,
                    onPressed: () {
                      Get.toNamed(Routes.USERINFORMATION);
                    }),
                buildMenuItem(
                    text: 'Log out',
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
