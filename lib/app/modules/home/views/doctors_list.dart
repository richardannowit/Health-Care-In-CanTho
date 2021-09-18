import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/home/views/components/doctors_card.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
          child: Column(
            children: [
              DoctorCard(
                img: 'assets/images/dr_1.png',
                name: 'Dr. Fred Mask',
                speciality: 'Heart surgen',
                rating: '4.1',
              ),
              DoctorCard(
                img: 'assets/images/dr_1.png',
                name: 'Dr. Fred Mask',
                speciality: 'Heart surgen',
                rating: '4.1',
              ),
              DoctorCard(
                img: 'assets/images/dr_1.png',
                name: 'Dr. Fred Mask',
                speciality: 'Heart surgen',
                rating: '4.1',
              ),
              DoctorCard(
                img: 'assets/images/dr_1.png',
                name: 'Dr. Fred Mask',
                speciality: 'Heart surgen',
                rating: '4.1',
              ),
              DoctorCard(
                img: 'assets/images/dr_1.png',
                name: 'Dr. Fred Mask',
                speciality: 'Heart surgen',
                rating: '4.1',
              ),
              DoctorCard(
                img: 'assets/images/dr_1.png',
                name: 'Dr. Fred Mask',
                speciality: 'Heart surgen',
                rating: '4.1',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
