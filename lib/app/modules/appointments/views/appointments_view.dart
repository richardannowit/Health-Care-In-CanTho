import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_loader.dart';
import 'package:flutter_healthcare/app/data/helper/create_chatroom_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/dialog.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/components/appointnent_card.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/constants.dart';
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
              title: Text('Cuộc hẹn', style: TextStyle(color: primaryColor)),
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
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Obx(() {
                  return buildList(context);
                }),
              ),
            ],
          )),
    );
  }

  Widget buildList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<AppointmentModel>>(
        stream:
            controller.getData(controller.less.value, controller.greater.value),
        builder: (BuildContext context,
            AsyncSnapshot<List<AppointmentModel>> appointmentsSnapshot) {
          if (appointmentsSnapshot.hasError)
            return new Text('Error: ${appointmentsSnapshot.error}');
          switch (appointmentsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
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
          height: 276,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: Stack(
              children: [
                Drawer(
                  child: ListView(
                    children: <Widget>[
                      Container(
                          width: 210,
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bộ lọc',
                                style: fillText,
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.grey[600],
                              ),
                            ],
                          )),
                      buildMenuItem(
                          text: 'Tất cả',
                          icon: Icons.all_out_outlined,
                          iconColor: Colors.red[300]),
                      buildMenuItem(
                          text: 'Đang chờ',
                          icon: Icons.fiber_manual_record,
                          iconColor: Colors.green[300]),
                      buildMenuItem(
                          text: 'Đã khám',
                          icon: Icons.fiber_manual_record,
                          iconColor: Colors.blue[300]),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: 210,
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey[600],
                                ),
                                Text(
                                  'Đóng',
                                  style: fillText,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ))
    ]);
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required iconColor,
  }) {
    final hoverColor = primaryColor;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: fillText,
      ),
      hoverColor: hoverColor,
      onTap: () {
        if (controller.statusFilter != text) {
          if (text == "Tất cả") {
            controller.less.value = "Z";
            controller.greater.value = "A";
          } else {
            if (text == "Đang chờ") {
              controller.less.value = "Active";
              controller.greater.value = "Active";
            } else {
              controller.less.value = "Done";
              controller.greater.value = "Done";
            }
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
