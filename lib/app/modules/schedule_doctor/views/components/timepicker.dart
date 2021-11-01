import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  TimePicker({
    Key? key,
    required this.label,
    required this.selectedTime,
    required this.onPress,
  }) : super(key: key);

  final String label, selectedTime;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color(0xFF000000).withOpacity(0.25),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                onPress();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTime,
                    style: TextStyle(
                      color: Color(0xff504848),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xff3668FC),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
