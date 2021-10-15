import 'package:flutter/material.dart';

final roundedContainer = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(0),
    bottomRight: Radius.circular(0),
    topLeft: Radius.circular(40),
    topRight: Radius.circular(40),
  ),
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 7),
      blurRadius: 20,
      color: Colors.grey.withOpacity(0.23),
    ),
  ],
);
