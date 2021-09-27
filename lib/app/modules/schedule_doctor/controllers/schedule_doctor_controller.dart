import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
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

  //---------- Getter/Setter ---------------//

  final scrollController = ScrollController();

  void onDateChange(DateTime newDate) {
    selectedDate = newDate;
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

  @override
  void onInit() {
    super.onInit();
    doctorProfile = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
