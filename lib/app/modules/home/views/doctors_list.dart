import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';
import 'package:flutter_healthcare/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_healthcare/app/modules/home/views/components/doctors_card.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DoctorsList extends StatelessWidget {
  DoctorsList({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final UserModel user;

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                child: Text(
                  "Tìm bác sĩ quanh bạn",
                  style: TextStyle(
                    color: Color(0xff016565),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DOCTORS_LIST);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xff016565),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, right: 20),
          child: Obx(() {
            var doctorList = controller.doctorList;
            if (doctorList.length == 0) {
              return Text("Không có bác sĩ nào trong khu vực của bạn");
            }
            return ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: size.height / 2, minHeight: 100.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: doctorList.length,
                itemBuilder: (_, index) {
                  return DoctorCard(
                    img: 'assets/images/dr_1.png',
                    name: doctorList[index].name!,
                    speciality: doctorList[index].specialist!,
                    rating: doctorList[index].rating!.toStringAsFixed(1),
                    onPressed: () {
                      Get.toNamed(Routes.DOCTORPERSIONALPAGE,
                          arguments: doctorList[index]);
                    },
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
