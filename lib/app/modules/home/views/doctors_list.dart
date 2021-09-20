import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_healthcare/app/modules/home/views/components/doctors_card.dart';
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
                  "Doctors List in your area",
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
                    onTap: () {},
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
          height: size.height,
          child: FutureBuilder(
            future: DatabaseMethods.getDoctors(user.address!.reference!),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              var doctorList = snapshot.data as List<DoctorModel>;
              print(doctorList);
              if (doctorList.length == 0) {
                return Text("No doctor yet");
              }

              return ListView.builder(
                itemCount: doctorList.length,
                itemBuilder: (_, index) {
                  return DoctorCard(
                    img: 'assets/images/dr_1.png',
                    name: doctorList[index].name!,
                    speciality: doctorList[index].specialist!,
                    rating: doctorList[index].rating.toString(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
