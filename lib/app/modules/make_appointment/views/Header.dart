import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({
    required this.height,
    required this.name,
    required this.specialist,
    Key? key,
  }) : super(key: key);

  final height;
  final String name, specialist;

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
              name,
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
              "Khoa " + specialist,
              style: TextStyle(
                color: Color(0xff164220),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
