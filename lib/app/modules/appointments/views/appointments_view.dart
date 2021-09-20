import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointment.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/components/appointnent_card.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/appointments_controller.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text('Appointments'),
            centerTitle: true,
            shadowColor: Colors.white,
            actions: <Widget>[
              new IconButton(
                  onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
                  icon: new Icon(Icons.filter_list_alt))
            ],
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.offAllNamed(Routes.HOME);
                })),
        endDrawer: buildDrawer(context),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: buildList(context),
        ));
  }

  Widget buildList(BuildContext context) {
    var streamBuilder = StreamBuilder<List<Appointment>>(
        stream: controller.getData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Appointment>> appointmentsSnapshot) {
          if (appointmentsSnapshot.hasError)
            return new Text('Error: ${appointmentsSnapshot.error}');
          switch (appointmentsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return new ListView(
                  children: appointmentsSnapshot.data!.map((Appointment app) {
                return Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Slidable(
                        child: AppointmentCard(
                          image: 'assets/images/tooth.png',
                          name: app.specialist,
                          appointment: app,
                        ),
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.2,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Cancel',
                            icon: Icons.cancel,
                            onTap: () {},
                          )
                        ]));
              }).toList());
          }
        });
    return streamBuilder;
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          children: <Widget>[
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
    );
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
        print(text);
      },
    );
  }
}
