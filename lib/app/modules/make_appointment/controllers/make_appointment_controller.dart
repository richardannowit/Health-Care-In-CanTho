import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class MakeAppointmentController extends GetxController {
  Rx<DoctorModel> _doctorProfile = new DoctorModel().obs;
  DoctorModel get doctorProfile => _doctorProfile.value;
  set doctorProfile(value) => _doctorProfile.value = value;

  RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  Rx<DateTime> _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate.value = value;

  RxList<DateTime> _timeSlotList = new List<DateTime>.empty(growable: true).obs;
  List<DateTime> get timeSlotList => _timeSlotList;
  set timeSlotList(value) => _timeSlotList.value = value;

  RxList<dynamic> _deleteSlotList = new List<dynamic>.empty(growable: true).obs;
  List<dynamic> get deleteSlotList => _deleteSlotList;
  set deleteSlotList(value) => _deleteSlotList.value = value;

  void onDateChange(DateTime newDate) async {
    selectedDate = newDate;
    loading = true;
    await loadData();
    loading = false;
  }

  bool isDate(DateTime thisDate, DateTime _selected) {
    final selected = DateTime(
      _selected.year,
      _selected.month,
      _selected.day,
    );

    return selected.compareTo(thisDate) == 0;
  }

  bool isLessThanNow(DateTime date) {
    final now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return now.compareTo(date) > 0;
  }

  bool isNow(DateTime date) {
    final now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return now.compareTo(date) == 0;
  }

  Future<void> loadData() async {
    loading = true;
    timeSlotList = await DatabaseMethods.getTimeSlotList(
        doctorProfile.docId!, selectedDate);
    deleteSlotList = await DatabaseMethods.getTimeSlotDeleted(
        doctorProfile.docId!, selectedDate);
    deleteSlotList.forEach((element) {
      timeSlotList.removeAt(element);
    });
    loading = false;
  }

  @override
  void onInit() async {
    super.onInit();
    doctorProfile = Get.arguments;
    loading = true;
    await loadData();
    loading = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
