import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:get/get.dart';

class InfomationUser extends StatelessWidget {
  InfomationUser({
    Key? key,
    required this.size,
    required this.name,
    required this.scaffoldKey,
  }) : super(key: key);

  final Size size;
  final String name;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                child: Container(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(
                    child: Image(
                      image: AssetImage('assets/images/avt_patient.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          HelloText(name: name)
        ],
      ),
    );
  }
}

class HelloText extends StatelessWidget {
  const HelloText({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Xin chào bác sĩ, ",
          style: TextStyle(
            fontFamily: "Roboto",
            color: Color(0xff898484),
            fontSize: 24,
            letterSpacing: 3.5,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            color: Color(0xff7B7171),
            fontSize: 26,
          ),
        ),
      ],
    );
  }
}
