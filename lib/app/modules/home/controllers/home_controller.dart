import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/calculate_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
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

  Rx<UserModel> _userInfo = new UserModel().obs;
  UserModel get userInfo => _userInfo.value;
  set userInfo(value) => _userInfo.value = value;

  RxList<AppointmentModel> _appointmentList =
      new List<AppointmentModel>.empty(growable: true).obs;
  List<AppointmentModel> get appointmentList => _appointmentList;
  set appointmentList(value) => _appointmentList.value = value;

  RxList<DoctorModel> _doctorList =
      new List<DoctorModel>.empty(growable: true).obs;
  List<DoctorModel> get doctorList => _doctorList;
  set doctorList(value) => _doctorList.value = value;

  RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

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

  Future<List<AppointmentModel>> getAppointmentList() async {
    return DatabaseMethods.getAppointments(userInfo.email!);
  }

  Future<List<DoctorModel>> getDoctorList() async {
    if (userInfo.address!.reference != null) {
      print(userInfo.address);
      return DatabaseMethods.getDoctors(userInfo.address!.reference!);
    }

    return DatabaseMethods.getDoctors();
    // return DatabaseMethods.getDoctors();
  }

  void signOut() {
    AuthMethods().signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Get.offAllNamed(Routes.LOGIN);
  }

  Future loadData() async {
    loading = true;
    userInfo = await getUserInfo();
    appointmentList = await getAppointmentList();
    doctorList = await getDoctorList();
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
