import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/services/auth.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeDoctorController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  Rx<DoctorModel> _doctorProfile = new DoctorModel().obs;
  DoctorModel get doctorProfile => _doctorProfile.value;
  set doctorProfile(value) => _doctorProfile.value = value;

  Future<DoctorModel> getDoctorProfile() async {
    if (user != null) {
      DoctorModel data = await DatabaseMethods.getDoctorProfiles(user!.uid);
      return data;
    }
    return new DoctorModel();
  }

  void signOut() {
    AuthMethods().signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Get.offAllNamed(Routes.LOGIN);
  }

  Future loadData() async {
    loading = true;
    user = _auth.currentUser;
    var isDoctor = await DatabaseMethods.isDoctor(user!.uid);
    if (!isDoctor) {
      Get.offAllNamed(Routes.HOME);
    }

    doctorProfile = await getDoctorProfile();

    loading = false;
  }

  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
