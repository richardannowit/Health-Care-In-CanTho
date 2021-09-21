import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotpasswordController extends GetxController {
  String email = "";
  bool success = false;
  final auth = FirebaseAuth.instance;
  var text = "".obs;
  var bgColor = MaterialStateProperty.all<Color>(Colors.white).obs;
  var fgColor = MaterialStateProperty.all<Color>(Colors.blueAccent).obs;
}
