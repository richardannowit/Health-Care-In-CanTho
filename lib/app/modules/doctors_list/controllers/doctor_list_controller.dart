import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/models/district.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class DoctorListController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  RxString districtName = 'Bình Thuỷ'.obs;

  District district = Get.put(District());
  DatabaseMethods databaseMethods = Get.put(DatabaseMethods());
  var currentIndex = 0.obs;

  Rx<UserModel> _userInfo = new UserModel().obs;
  UserModel get userInfo => _userInfo.value;
  set userInfo(value) => _userInfo.value = value;

  Future<UserModel> getUserInfo() async {
    user = _auth.currentUser;
    if (user != null) {
      UserModel data = await databaseMethods.getUserByUID(user!.uid);
      return data;
    }
    return new UserModel();
  }

  @override
  void onInit() async {
    super.onInit();
    await getUserInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  // void changeCategories(index) {
  //   currentIndex(index);
  //   getDoctorsByDistrict(index);
  // }

  changeCategories(var value) {
    this.districtName.value = value;
  }
}
