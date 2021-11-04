import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({
    required this.height,
    Key? key,
  }) : super(key: key);

  final height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              child: CircleAvatar(
                child: Image(
                  image: AssetImage('assets/images/avt_doctor.png'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dr. Dang Khoa',
              style: TextStyle(
                color: Color(0xff734B10),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Heart',
              style: TextStyle(
                color: Color(0xff164220),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
