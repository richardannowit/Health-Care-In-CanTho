import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class ScheduleDoctorController extends GetxController {
  Rx<DoctorModel> _doctorProfile = new DoctorModel().obs;
  DoctorModel get doctorProfile => _doctorProfile.value;
  set doctorProfile(value) => _doctorProfile.value = value;

  Rx<DateTime> _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate.value = value;

  Rx<TimeOfDay> _timeStart = new TimeOfDay(hour: 07, minute: 00).obs;
  TimeOfDay get timeStart => _timeStart.value;
  set timeStart(value) => _timeStart.value = value;

  Rx<TimeOfDay> _timeFinish = new TimeOfDay(hour: 17, minute: 00).obs;
  TimeOfDay get timeFinish => _timeFinish.value;
  set timeFinish(value) => _timeFinish.value = value;

  Rx<TimeOfDay> _timeRelaxStart = new TimeOfDay(hour: 11, minute: 00).obs;
  TimeOfDay get timeRelaxStart => _timeRelaxStart.value;
  set timeRelaxStart(value) => _timeRelaxStart.value = value;

  Rx<TimeOfDay> _timeRelaxFinish = new TimeOfDay(hour: 13, minute: 30).obs;
  TimeOfDay get timeRelaxFinish => _timeRelaxFinish.value;
  set timeRelaxFinish(value) => _timeRelaxFinish.value = value;

  Rx<TimeOfDay> _duration = new TimeOfDay(hour: 00, minute: 30).obs;
  TimeOfDay get duration => _duration.value;
  set duration(value) => _duration.value = value;

  RxList<DateTime> _timeSlotList = new List<DateTime>.empty(growable: true).obs;
  List<DateTime> get timeSlotList => _timeSlotList;
  set timeSlotList(value) => _timeSlotList.value = value;

  RxList<dynamic> _deleteSlotList = new List<dynamic>.empty(growable: true).obs;
  List<dynamic> get deleteSlotList => _deleteSlotList;
  set deleteSlotList(value) => _deleteSlotList.value = value;

  RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  //---------- Getter/Setter ---------------//

  final scrollController = ScrollController();

  void resetTime() {
    timeStart = TimeOfDay(hour: 07, minute: 00);
    timeFinish = TimeOfDay(hour: 17, minute: 00);
    timeRelaxStart = TimeOfDay(hour: 11, minute: 00);
    timeRelaxFinish = TimeOfDay(hour: 13, minute: 30);
  }

  void onDateChange(DateTime newDate) async {
    resetTime();
    selectedDate = newDate;
    loading = true;
    await loadData();
    loading = false;
  }

  void deleteTimeLine() async {
    // TODO: Check have booking does not accept delete
    await DatabaseMethods.deleteTimeLineOfDoctor(
        doctorProfile.docId!, selectedDate);
    loading = true;
    await loadData();
    loading = false;
  }

  void deleteTimeSlot(int index) async {
    // TODO: Check have booking does not accept delete
    loading = true;
    await DatabaseMethods.deleteTimeSlot(
        doctorProfile.docId!, selectedDate, index);

    await loadData();
    loading = false;
  }

  Future<void> loadData() async {
    deleteSlotList = await DatabaseMethods.getTimeSlotDeleted(
        doctorProfile.docId!, selectedDate);
    timeSlotList = await DatabaseMethods.getTimeSlotList(
        doctorProfile.docId!, selectedDate);
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

  bool isDate(DateTime thisDate, DateTime _selected) {
    final selected = DateTime(
      _selected.year,
      _selected.month,
      _selected.day,
    );

    return selected.compareTo(thisDate) == 0;
  }

  showSelectedTime(context, time) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: time,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (result != null) {
      return result;
    }
    return time;
  }

  void makeSchedule() async {
    DateTime timeStart =
        DateTimeHelpers.timeOfDayToDateTime(selectedDate, this.timeStart);
    DateTime timeFinish =
        DateTimeHelpers.timeOfDayToDateTime(selectedDate, this.timeFinish);
    DateTime timeRelaxStart =
        DateTimeHelpers.timeOfDayToDateTime(selectedDate, this.timeRelaxStart);
    DateTime timeRelaxFinish =
        DateTimeHelpers.timeOfDayToDateTime(selectedDate, this.timeRelaxFinish);
    List<DateTime> _time_slot = new List<DateTime>.empty(growable: true);

    if (timeStart.compareTo(timeFinish) > 0) {
      Get.snackbar(
        "Set wrong time!",
        "Time Start must be less than Time Finish.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (timeRelaxStart.compareTo(timeRelaxFinish) > 0) {
      Get.snackbar(
        "Set wrong time!",
        "Time Relax Start must be less than Time Relax Finish.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    while (true) {
      if (timeStart.compareTo(timeFinish) > 0) break;
      if (timeStart.compareTo(timeRelaxStart) < 0 ||
          timeStart.compareTo(timeRelaxFinish) >= 0) {
        _time_slot.add(timeStart);
      }

      timeStart = timeStart
          .add(Duration(hours: duration.hour, minutes: duration.minute));
    }
    bool insertSuccess = await DatabaseMethods.addTimeLineForDoctor(
        doctorProfile.docId!, selectedDate, _time_slot);
    if (insertSuccess) {
      Get.snackbar(
        "Make Schedule",
        "Schedule is added successful",
        snackPosition: SnackPosition.BOTTOM,
      );
      loading = true;
      await loadData();
      loading = false;
    } else {
      Get.snackbar(
        "Make Schedule!",
        "Error to add timeline",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    doctorProfile = Get.arguments;
    resetTime();
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
