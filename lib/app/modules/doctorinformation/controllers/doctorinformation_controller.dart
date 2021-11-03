import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/models/review.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/views/updateview.dart';
import 'package:get/get.dart';

class DoctorinformationController extends GetxController {
  bool isFirst = false;
  late List<AddressModel> listAddress;
  final String doctorId = FirebaseAuth.instance.currentUser!.uid;
  final String? email = FirebaseAuth.instance.currentUser!.email;
  final DatabaseMethods databaseMethods = Get.put(DatabaseMethods());
  DoctorModel newDoctor = new DoctorModel();
  late String initName,
      initPhone,
      initSpecialist,
      initAbout,
      initCenterAddreess;

  Rx<DoctorModel> _doctorInfo = new DoctorModel().obs;
  DoctorModel get doctorInfo => _doctorInfo.value;
  set doctorInfo(value) => _doctorInfo.value = value;

  Rx<IconData> _viewMode = Icons.remove_red_eye.obs;
  IconData get viewMode => _viewMode.value;
  set viewMode(value) => _viewMode.value = value;

  RxBool _flag = false.obs;
  bool get flag => _flag.value;
  set flag(value) => _flag.value = value;

  RxBool _loading = true.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  RxBool _isUpdate = false.obs;
  bool get isUpdate => _isUpdate.value;
  set isUpdate(value) => _isUpdate.value = value;

  Rx<String> _doctorName = '...'.obs;
  String get doctorName => _doctorName.value;
  set doctorName(value) => _doctorName.value = value;

  Rx<String> _specialist = '...'.obs;
  String get specialist => _specialist.value;
  set specialist(value) => _specialist.value = value;

  Rx<String> _addressName = '...'.obs;
  String get addressName => _addressName.value;
  set addressName(value) => _addressName.value = value;

  RxList<ReviewModel> _reviewList =
      new List<ReviewModel>.empty(growable: true).obs;
  List<ReviewModel> get reviewList => _reviewList;
  set reviewList(value) => _reviewList.value = value;

  RxString _hint = 'Ninh Kieu'.obs;
  String get hint => _hint.value;
  set hint(value) => _hint.value = value;

  loadData() async {
    loading = true;
    doctorInfo = await databaseMethods.getDoctorById(doctorId);
    listAddress = await databaseMethods.getDistricts();
    reviewList = await DatabaseMethods.getReviews(doctorId);
    removeNullFields();
    loading = false;
    checkIsFrist();
  }

  checkIsFrist() {
    if (isFirst) {
      isFirst = false;
      makeHint();
      Get.to(UpdateView());
    }
  }

  removeNullFields() {
    if (doctorInfo.email == null) {
      doctorInfo.email = FirebaseAuth.instance.currentUser!.email;
    }

    if (doctorInfo.name == null) {
      doctorName = 'Wating for your update';
    } else {
      doctorName = doctorInfo.name;
    }

    if (doctorInfo.specialist == null) {
      specialist = 'Waiting for your update';
    } else {
      specialist = doctorInfo.specialist;
    }

    if (doctorInfo.about == null) {
      doctorInfo.about = 'Waiting for your update';
    }

    if (doctorInfo.rating == null) {
      doctorInfo.rating = 0;
    }
    if (doctorInfo.phone == null) {
      doctorInfo.phone = 'Waiting for your update';
    }
    if (doctorInfo.centeraddress == null) {
      doctorInfo.centeraddress = 'Waiting for your update';
    }

    if (doctorInfo.address == null) {
      addressName = 'Waiting for your update';
      isFirst = true;
    } else {
      if (doctorInfo.address!.name == 'NULL') {
        addressName = 'Waiting for your update';
        isFirst = true;
      } else {
        addressName = doctorInfo.address!.name! + ', Cần Thơ';
        isUpdate = true;
      }
    }
  }

  makeHint() {
    hint = listAddress[0].name;
    newDoctor.addressRef = listAddress[0].reference;
    newDoctor.email = FirebaseAuth.instance.currentUser!.email;
    if (doctorInfo.name == null) {
      newDoctor.name = 'Ex: Vo Tu Thien';
      initName = '';
    } else {
      newDoctor.name = doctorInfo.name;
      initName = doctorInfo.name!;
    }

    if (doctorInfo.specialist == null) {
      newDoctor.specialist = 'Ex: Heart';
      initSpecialist = '';
    } else {
      newDoctor.specialist = doctorInfo.specialist;
      initSpecialist = doctorInfo.specialist!;
    }

    if (doctorInfo.about == 'Waiting for your update') {
      newDoctor.about =
          'Ex: Renowned doctor who participated in heart transplants abroad';
      initAbout = '';
    } else {
      newDoctor.about = doctorInfo.about;
      initAbout = doctorInfo.about!;
    }

    if (doctorInfo.rating == null) {
      newDoctor.rating = 0;
    } else {
      newDoctor.rating = doctorInfo.rating;
    }
    if (doctorInfo.phone == 'Waiting for your update') {
      newDoctor.phone = 'Ex: 0812305346';
      initPhone = '';
    } else {
      newDoctor.phone = doctorInfo.phone;
      initPhone = doctorInfo.phone!;
    }
    if (doctorInfo.centeraddress == 'Waiting for your update') {
      newDoctor.centeraddress = 'Ex: 331 Ba Thang Hai Street, Hung Loi';
      initCenterAddreess = '';
    } else {
      newDoctor.centeraddress = doctorInfo.centeraddress;
      initCenterAddreess = doctorInfo.centeraddress!;
    }
    if (doctorInfo.address != null) {
      if (doctorInfo.address.name != 'NULL') {
        newDoctor.addressRef = doctorInfo.address.reference;
        hint = doctorInfo.address.name;
      }
    }
  }

  updateDoctorInfo() {
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorId)
        .set(newDoctor.toJson());
    isUpdate = true;
  }

  changeViewMode() {
    if (viewMode == Icons.remove_red_eye) {
      viewMode = Icons.remove_red_eye_outlined;
    } else {
      viewMode = Icons.remove_red_eye;
    }
    flag = !flag;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
