import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/calculate_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/services/auth.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
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

      if (data.containsKey('height') == true &&
          data.containsKey('weight') == true) {
        dynamic height = data['height'];
        dynamic weight = data['weight'];
        bmi.value = CalculateHelpers.calculateBMI(weight, height);
      }
    }
  }

  void signOut() {
    AuthMethods().signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Get.offAllNamed(Routes.LOGIN);
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
