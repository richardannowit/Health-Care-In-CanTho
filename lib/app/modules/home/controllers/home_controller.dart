import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/calculate_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';
import 'package:flutter_healthcare/app/data/services/auth.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  RxString bmi = "".obs;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Future<UserModel> getUserInfo() async {
    user = _auth.currentUser;
    if (user != null) {
      UserModel data = await databaseMethods.getUserByUID(user!.uid);
      user?.updateDisplayName(data.name);
      user?.updateEmail(data.email!);

      if (data.height != null && data.weight != null) {
        dynamic height = data.height;
        dynamic weight = data.weight;
        bmi.value = CalculateHelpers.calculateBMI(weight, height);
      }
      return data;
    }
    return new UserModel();
  }

  void signOut() {
    AuthMethods().signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
