import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  RxString bmi = "".obs;

  Future<void> _getUserInfo() async {
    DatabaseMethods databaseMethods = new DatabaseMethods();
    user = _auth.currentUser;
    if (user != null) {
      Map<String, dynamic> data = await databaseMethods.getUserByUID(user!.uid);
      user?.updateDisplayName(data['name']);
      user?.updateEmail(data['email']);

      if (data.containsKey('height') && data.containsKey('weight')) {
        double height = data['height'];
        double weight = data['weight'];
        bmi.value = calculateBMI(weight, height);
      }
    }
  }

  String calculateBMI(double weight, double height) {
    var _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  @override
  void onInit() {
    super.onInit();
    _getUserInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
