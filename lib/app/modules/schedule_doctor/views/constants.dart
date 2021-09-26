import 'package:flutter/material.dart';

final buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.0),
      side: BorderSide(color: Colors.red),
    ),
  ),
);
