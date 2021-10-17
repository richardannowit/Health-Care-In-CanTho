import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/views/constants.dart';

class AppointmentCard extends StatelessWidget {
  AppointmentCard({
    Key? key,
    this.doctor_image,
    this.doctor_name,
    this.specialist,
    this.date,
    this.time,
    this.status,
  }) : super(key: key);

  final String? doctor_image, doctor_name, specialist, date, time, status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xff107163),
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
                      doctor_name!,
                      style: largeTextStyle.copyWith(color: Colors.white),
                    ),
                    Text(
                      specialist!,
                      style: mediumTextStyle.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                CircleAvatar(
                  child: Image(
                    image: AssetImage(doctor_image!),
                  ),
                )
              ],
            ),
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
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        color:
                            status == 'Waiting' ? Colors.yellow : Colors.green,
                      ),
                      Text(
                        status!,
                        style: smallTextStyle.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                width: 200,
                height: 30,
              ),
              child: ElevatedButton(
                style: buttonStyle,
                child: Text(
                  "Cancel appointment",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                onPressed: () {
                  //
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
