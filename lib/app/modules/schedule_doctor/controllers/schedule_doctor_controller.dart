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
