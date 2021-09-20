import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointment.dart';

import '../constants.dart';

class AppointmentCard extends StatelessWidget {
  AppointmentCard(
      {Key? key, this.image, this.name, this.drCount, this.appointment})
      : super(key: key);

  final String? image, name, drCount;
  final Appointment? appointment;
  Color? backgroundColor, recordColor;

  @override
  Widget build(BuildContext context) {
    initColor(appointment!.status);
    return Container(
      width: 350,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment!.doctorName,
                      style: largeTextStyle.copyWith(color: Colors.white),
                    ),
                    Text(
                      name!,
                      style: mediumTextStyle.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                CircleAvatar(
                  child: Image(
                    image: AssetImage('assets/images/avt_doctor.png'),
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.event_available,
                        color: Colors.white,
                      ),
                      Text(
                        appointment!.getDate(),
                        style: smallTextStyle.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: Colors.white,
                      ),
                      Text(
                        appointment!.getTime(),
                        style: smallTextStyle.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        color: recordColor,
                      ),
                      Text(
                        appointment!.getStatus(),
                        style: smallTextStyle.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  initColor(String status) {
    switch (status) {
      case "active":
        recordColor = Colors.green[300];
        backgroundColor = Colors.green[700];
        break;
      case "waiting":
        recordColor = Colors.amber[300];
        backgroundColor = Colors.amber[700];
        break;

      default:
        recordColor = Colors.blue[300];
        backgroundColor = Colors.blue[700];
    }
  }
}
