import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointment.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/components/appointnent_card.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/appointments_controller.dart';

class AppointmentsView extends StatefulWidget {
  const AppointmentsView({Key? key}) : super(key: key);

  @override
  _AppointmentsViewState createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppointmentsController controller = Get.put(AppointmentsController());
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
        if (controller.statusFilter != text) {
          setState(() {
            if (text == "All") {
              controller.less = "z";
              controller.greater = "a";
            } else {
              controller.less = text.toLowerCase();
              controller.greater = text.toLowerCase();
            }
            controller.statusFilter = text;
          });
        }
      },
    );
  }
}
