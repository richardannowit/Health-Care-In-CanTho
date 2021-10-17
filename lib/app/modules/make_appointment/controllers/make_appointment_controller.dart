import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class MakeAppointmentController extends GetxController {
  //TODO: Create booking success screen
  final userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  Rx<DoctorModel> _doctorProfile = new DoctorModel().obs;
  DoctorModel get doctorProfile => _doctorProfile.value;
  set doctorProfile(value) => _doctorProfile.value = value;

  RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  RxInt _selectedTime = (-1).obs;
  int get selectedTime => _selectedTime.value;
  set selectedTime(value) => _selectedTime.value = value;

  Rx<DateTime> _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate.value = value;

  RxList<Map<String, dynamic>> _timeSlotList =
      new List<Map<String, dynamic>>.empty(growable: true).obs;
  List<Map<String, dynamic>> get timeSlotList => _timeSlotList;
  set timeSlotList(value) => _timeSlotList.value = value;

  RxList<dynamic> _deleteSlotList = new List<dynamic>.empty(growable: true).obs;
  List<dynamic> get deleteSlotList => _deleteSlotList;
  set deleteSlotList(value) => _deleteSlotList.value = value;

  RxList<dynamic> _bookedSlotList = new List<dynamic>.empty(growable: true).obs;
  List<dynamic> get bookedSlotList => _bookedSlotList;
  set bookedSlotList(value) => _bookedSlotList.value = value;

  void onDateChange(DateTime newDate) async {
    selectedDate = newDate;
    loading = true;
    await loadData();
    loading = false;
  }

  void onTimeChange(int index) async {
    selectedTime = index;
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

  void resetState() {
    selectedTime = -1;
  }

  Future<void> loadData() async {
    loading = true;
    resetState();
    deleteSlotList = await DatabaseMethods.getTimeSlotDeleted(
        doctorProfile.docId!, selectedDate);
    bookedSlotList =
        await DatabaseMethods.getBookedSlot(doctorProfile.docId!, selectedDate);

    List<DateTime> _timeSlot = await DatabaseMethods.getTimeSlotList(
        doctorProfile.docId!, selectedDate);
    List<Map<String, dynamic>> _timeSlotList =
        new List<Map<String, dynamic>>.empty(growable: true);
    for (int i = 0; i < _timeSlot.length; i++) {
      bool isValid = true;
      if (bookedSlotList.contains(i)) {
        isValid = false;
      }
      _timeSlotList.add({
        'index': i,
        'time': _timeSlot[i],
        'valid': isValid,
      });
    }
    timeSlotList = _timeSlotList;

    // Sort deleteSlot with desc and remove to avoid wrong index
    deleteSlotList.sort();
    deleteSlotList = deleteSlotList.reversed.toList();
    deleteSlotList.forEach((element) {
      timeSlotList.removeAt(element);
    });
    loading = false;
  }

  Future<bool> bookAppointment() async {
    final bookingTime = timeSlotList[selectedTime]['time'];
    final slotIndex = timeSlotList[selectedTime]['index'];
    Map<String, dynamic> data = {
      'doctor': doctorProfile.reference,
      'patient': userEmail,
      'status': 'Waiting',
      'appointment_date': DateTimeHelpers.dateTimeToTimestamp(bookingTime),
      'time_slot': slotIndex
    };
    bool markSucess = await DatabaseMethods.markTimeIndex(
        doctorProfile.docId!, selectedDate, slotIndex);
    bool bookSucess =
        markSucess ? await DatabaseMethods.createAppointment(data) : false;

    bool check = true;
    if (!bookSucess || !markSucess) {
      check = false;
    }
    return check;
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
