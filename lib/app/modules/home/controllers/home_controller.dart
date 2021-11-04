import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/calculate_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/constants.dart';
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
    // TODO: Instead get user from firebase, we get user from local storage
    user = _auth.currentUser;
    if (user != null) {
      UserModel data = await databaseMethods.getUserByUID(user!.uid);

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
    return DatabaseMethods.getAppointments(userInfo.email ?? '');
    // TODO: userInfo will be delete temporary when click back in home and enter again
  }

  Future<List<DoctorModel>> getDoctorList() async {
    if (userInfo.address?.reference != null) {
      print(userInfo.address);
      return DatabaseMethods.getDoctors(userInfo.address!.reference!);
    }

    return DatabaseMethods.getDoctors();
  }

  void signOut() {
    AuthMethods().signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> cancelAppointment(int index) async {
    bool isCancel =
        await DatabaseMethods.deleteAppointment(appointmentList[index]);
    if (!isCancel) {
      Get.snackbar(
        "Cancel appointment error!",
        "You can't delete this appointment.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // print(appointmentList[index].doctor!.email);
    loadData();
  }

  Future loadData() async {
    loading = true;
    user = _auth.currentUser;
    Constants.myName =
        (await HelperFunctions.getUserEmailSharedPreference()) ?? '';
    var doctorSnap = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(user!.uid)
        .get();
    if (doctorSnap.exists) {
      var doctor = doctorSnap.data() as Map<String, dynamic>;
      if (!doctor.containsKey('address')) {
        Get.offAllNamed(Routes.DOCTORINFORMATION, arguments: "isFirst");
        return;
      } else {
        await Get.offAllNamed(Routes.HOME_DOCTOR);
        return;
      }
    } else {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (userSnap.exists) {
        var user = userSnap.data() as Map<String, dynamic>;
        if (!user.containsKey('address')) {
          Get.offAllNamed(Routes.USERINFORMATION, arguments: "isFirst");
          return;
        }
      } else {
        Get.offAllNamed(Routes.CHOOSEROLE);
        return;
      }
    }
    userInfo = await getUserInfo();
    appointmentList = await getAppointmentList();
    doctorList = await getDoctorList();

    loading = false;
  }

  @override
  void onInit() async {
    super.onInit();
    user = _auth.currentUser;
    await loadData();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}
}
