import 'package:flutter/material.dart';

final formStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
  ),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 7),
      blurRadius: 20,
      color: Colors.grey.withOpacity(0.23),
    ),
  ],
);

final inputStyle = InputDecoration(
  hintText: "undefined",
  hintStyle: TextStyle(color: Color(0xffbdb7b7)),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffbdb7b7),
    ),
  ),
  prefixIcon: Icon(
    Icons.person,
  ),
);

final buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: BorderSide(color: Colors.blueAccent),
    ),
  ),
);
