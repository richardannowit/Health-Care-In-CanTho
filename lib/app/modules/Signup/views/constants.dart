import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';

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

InputDecoration _buildDecorationTextFormField(
    {required String hintText, required IconData icon}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 10),
    hintText: hintText,
    focusColor: primaryColor,
    prefixIcon: Icon(
      icon,
      color: primaryColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: primaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: secondaryColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: secondaryColor),
    ),
  );
}

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
