import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/data/helper/create_chatroom_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/dialog.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/components/appointnent_card.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/appointments_controller.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              backgroundColor: Colors.white,
              title:
                  Text('Appointments', style: TextStyle(color: primaryColor)),
              centerTitle: true,
              actions: <Widget>[
                new IconButton(
                    onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
                    icon: new Icon(
                      Icons.filter_list_alt,
                      color: primaryColor,
                    ))
              ],
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.HOME);
                  })),
          endDrawer: buildDrawer(context),
          body: Stack(
            children: [
              Background(height: MediaQuery.of(context).size.height),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Obx(() {
                  return buildList(context);
                }),
              ),
            ],
          )),
    );
  }

  Widget buildList(BuildContext context) {
    var streamBuilder = StreamBuilder<List<AppointmentModel>>(
        stream:
            controller.getData(controller.less.value, controller.greater.value),
        builder: (BuildContext context,
            AsyncSnapshot<List<AppointmentModel>> appointmentsSnapshot) {
          if (appointmentsSnapshot.hasError)
            return new Text('Error: ${appointmentsSnapshot.error}');
          switch (appointmentsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (appointmentsSnapshot.data!.isEmpty) {
                return buildNullList(context);
              }
              return new ListView(
                  children:
                      appointmentsSnapshot.data!.map((AppointmentModel app) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: AppointmentCard(
                    height: MediaQuery.of(context).size.height * 0.18,
                    doctor_image: 'assets/images/avt_doctor.png',
                    doctor_name: app.doctor!.name,
                    specialist: app.doctor!.specialist,
                    date:
                        DateTimeHelpers.timestampsToDate(app.appointment_date!),
                    time:
                        DateTimeHelpers.timestampsToTime(app.appointment_date!),
                    status: app.status,
                    onMessage: () => CreateChatRoom()
                        .createChatroomAndStartConversation(
                            app.doctor!.email!, app.doctor!.email!),
                    onCancel: () {
                      DialogHelper.showDialog(
                        content: 'Xác nhận huỷ lịch hẹn?',
                        confirmText: 'Xác nhận',
                        onConfirm: () {
                          controller.cancelAppointment(app);
                        },
                      );
                    },
                  ),
                );
              }).toList());
          }
        });
    return streamBuilder;
  }

  Widget buildDrawer(BuildContext context) {
    return Column(children: [
      Container(
          // margin: const EdgeInsets.only(top: 24),
          width: 200,
          height: 300,
          child: Drawer(
            child: Material(
              child: ListView(
                children: <Widget>[
                  buildMenuItem(
                      text: 'All',
                      icon: Icons.all_out_outlined,
                      iconColor: Colors.red[300]),
                  buildMenuItem(
                      text: 'Active',
                      icon: Icons.fiber_manual_record,
                      iconColor: Colors.green[300]),
                  buildMenuItem(
                      text: 'Waiting',
                      icon: Icons.fiber_manual_record,
                      iconColor: Colors.amber[300]),
                  buildMenuItem(
                      text: 'Done',
                      icon: Icons.fiber_manual_record,
                      iconColor: Colors.blue[300])
                ],
              ),
            ),
          ))
    ]);
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required iconColor,
  }) {
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text),
      hoverColor: hoverColor,
      onTap: () {
        if (controller.statusFilter != text) {
          if (text == "All") {
            controller.less.value = "Z";
            controller.greater.value = "A";
          } else {
            controller.less.value = text;
            controller.greater.value = text;
          }
          controller.statusFilter = text;
        }
        Get.back();
      },
    );
  }

  Widget buildNullList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Image(
              image: AssetImage('assets/images/avt_doctor.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text('Danh sách rỗng!',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
