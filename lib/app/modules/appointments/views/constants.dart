import 'package:flutter/material.dart';

const smallTextStyle = TextStyle(
  fontSize: 12,
);

const Color fgColor = Colors.blueAccent;

const mediumTextStyle = TextStyle(
  fontSize: 14,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

final fillText = TextStyle(
  color: Colors.grey[600],
  fontSize: 17,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

const largeTextStyle = TextStyle(
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

final buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: BorderSide(color: Colors.red),
    ),
  ),
);

final activeColor = new Color.fromRGBO(70, 238, 55, 100);
final waitingColor = new Color.fromRGBO(255, 245, 0, 100);
final doneColor = new Color.fromRGBO(80, 234, 243, 100);
