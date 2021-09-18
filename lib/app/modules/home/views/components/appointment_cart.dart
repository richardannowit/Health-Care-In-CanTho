import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/views/constants.dart';

class AppointmentCard extends StatelessWidget {
  AppointmentCard({Key? key, this.image, this.name, this.drCount})
      : super(key: key);

  final String? image, name, drCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      'Dr. Chris Frazier',
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
                        '12/03/2021',
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
                        '10:30 AM',
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
                        color: Colors.green,
                      ),
                      Text(
                        'Active',
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
