import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
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

  RxList<AppointmentModel> _appointmentList =
      new List<AppointmentModel>.empty(growable: true).obs;
  List<AppointmentModel> get appointmentList => _appointmentList;
  set appointmentList(value) => _appointmentList.value = value;

  Future<DoctorModel> getDoctorProfile() async {
    if (user != null) {
      DoctorModel data = await DatabaseMethods.getDoctorProfiles(user!.uid);
      return data;
    }
    return new DoctorModel();
  }

  Future<List<AppointmentModel>> getAppointmentList() async {
    return DatabaseMethods.getAppointmentsOfDoctor(doctorProfile.reference!);
  }

  void signOut() {
    AuthMethods().signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Get.offAllNamed(Routes.LOGIN);
  }

  Future loadData() async {
    loading = true;
    user = _auth.currentUser;
    doctorProfile = await getDoctorProfile();
    appointmentList = await getAppointmentList();
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
