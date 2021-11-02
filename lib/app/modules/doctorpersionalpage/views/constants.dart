import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';

final textStyle = TextStyle(
  color: Colors.grey[500],
  fontSize: 20,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final detailStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(0),
    bottomRight: Radius.circular(0),
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 7),
      blurRadius: 20,
      color: Colors.grey.withOpacity(0.23),
    ),
  ],
);

final cardStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)),
    boxShadow: [
      BoxShadow(
        color: primaryColor,
        blurRadius: 5,
      ),
    ]);
final bgColor = Colors.blue[300];

final reviewBtnStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: BorderSide(color: Colors.blueAccent),
    ),
  ),
);

final txtStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

final nameText = TextStyle(
  color: Colors.amber[700],
  fontSize: 26,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w800,
);

final informationText = TextStyle(
  color: Colors.grey[500],
  fontSize: 22,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);

final keyText = TextStyle(
  color: Colors.grey[800],
  fontSize: 22,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
);
