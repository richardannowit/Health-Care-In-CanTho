import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class InfomationUser extends StatelessWidget {
  InfomationUser({
    Key? key,
    required this.size,
    required this.name,
    required this.bmi,
  }) : super(key: key);

  final Size size;
  final String name, bmi;

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: EdgeInsets.only(top: 20, left: 20),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'Hi, ' + name,
                  style: TextStyle(
                    color: Color(0xff363636),
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.25,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'BMI: ' + bmi,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              controller.signOut();
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset("assets/images/profile_img.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
