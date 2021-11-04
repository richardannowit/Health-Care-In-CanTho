import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/constants.dart';

class AppointmentCard extends StatelessWidget {
  AppointmentCard({
    Key? key,
    this.doctor_image,
    this.doctor_name,
    this.specialist,
    this.date,
    this.time,
    this.status,
    this.height,
    required this.onCancel,
    required this.onMessage,
  }) : super(key: key);

  final String? doctor_image, doctor_name, specialist, date, time, status;
  final double? height;
  final GestureTapCallback onCancel;
  final GestureTapCallback onMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          AvatarAndMessage(
            height: height,
            onMessage: onMessage,
          ),
          VerticalDivider(
            color: Color(0xff5F6468),
            width: 40,
          ),
          Expanded(
            child: Stack(
              children: [
                CloseButton(onCancel: onCancel),
                AppointmentInfo(
                  status: status!,
                  doctor_name: doctor_name,
                  specialist: specialist,
                  date: date,
                  time: time,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({
    Key? key,
    required this.onCancel,
  }) : super(key: key);

  final GestureTapCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onCancel,
          child: Icon(
            Icons.clear_rounded,
            color: secondaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class AppointmentInfo extends StatelessWidget {
  const AppointmentInfo({
    Key? key,
    required this.doctor_name,
    required this.specialist,
    required this.date,
    required this.time,
    required this.status,
  }) : super(key: key);

  final String? doctor_name;
  final String? specialist;
  final String? date;
  final String? time;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor_name!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Icon(
                        Icons.fiber_manual_record,
                        color: getColor(status),
                        size: 26,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Khoa " + specialist!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
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
                    date!,
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
                  SizedBox(width: 5),
                  Text(
                    time!,
                    style: smallTextStyle.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Color getColor(String status) {
    var color = Colors.white;
    switch (status) {
      case 'Waiting':
        color = waitingColor;
        break;
      case 'Active':
        color = activeColor;
        break;
      default:
        color = doneColor;
    }
    return color;
  }
}

class AvatarAndMessage extends StatelessWidget {
  const AvatarAndMessage({
    Key? key,
    required this.height,
    required this.onMessage,
  }) : super(key: key);

  final double? height;
  final GestureTapCallback onMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 60,
            height: 60,
            child: CircleAvatar(
              child: Image(
                image: AssetImage('assets/images/avt_patient.png'),
              ),
            ),
          ),
          InkWell(
            onTap: onMessage,
            child: Container(
              child: Icon(
                Icons.message_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
