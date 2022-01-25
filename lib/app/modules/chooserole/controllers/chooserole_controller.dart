import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:get/get.dart';

class ChooseroleController extends GetxController {
  late int numberOfDoctor, numberOfPatient, sumOfUser;
  final String userID = FirebaseAuth.instance.currentUser!.uid;
  final carouselControllerDoctor = new CarouselController();
  final carouselControllerPatient = new CarouselController();
  final String? userEmail = FirebaseAuth.instance.currentUser!.email;
  bool isChoosed = false;
  bool isDoctor = false;
  var bgColor = MaterialStateProperty.all<Color>(Colors.white).obs;
  var fgColor = MaterialStateProperty.all<Color>(primaryColor).obs;
  var doctorCardBoder = Border.all(color: Colors.white, width: 0).obs;
  var patientCardBoder = Border.all(color: Colors.white, width: 0).obs;
  RxInt activeIndex = 0.obs;

  Rx<String> _doctorRate = '...'.obs;
  String get doctorRate => _doctorRate.value;
  set doctorRate(value) => _doctorRate.value = value;

  Rx<String> _patientRate = '...'.obs;
  String get patientRate => _patientRate.value;
  set patientRate(value) => _patientRate.value = value;

  Rx<double> _doctorPercent = 0.0.obs;
  double get doctorPercent => _doctorPercent.value;
  set doctorPercent(value) => _doctorPercent.value = value;

  Rx<double> _patientPercent = 0.0.obs;
  double get patientPercent => _patientPercent.value;
  set patientPercent(value) => _patientPercent.value = value;

  RxBool _autoDoctor = false.obs;
  bool get autoDoctor => _autoDoctor.value;
  set autoDoctor(value) => _autoDoctor.value = value;

  RxBool _autoPatient = false.obs;
  bool get autoPatient => _autoPatient.value;
  set autoPatient(value) => _autoPatient.value = value;

  loadData() async {
    await getNumberOfDoctor();
    await getNumberOfPatient();
    sumOfUser = numberOfDoctor + numberOfPatient;
    doctorRate =
        numberOfDoctor.toString() + "/" + sumOfUser.toString() + " Người dùng";
    patientRate =
        numberOfPatient.toString() + "/" + sumOfUser.toString() + " Người dùng";
    doctorPercent = numberOfDoctor.toDouble() / sumOfUser;
    patientPercent = numberOfPatient.toDouble() / sumOfUser;
  }

  chooseDoctor() {
    isDoctor = true;
    isChoosed = true;
  }

  choosePatient() {
    isDoctor = false;
    isChoosed = true;
  }

  transInformation(String collection) async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('newUsers')
        .doc(userID)
        .get();
    if (document.exists) {
      FirebaseFirestore.instance.collection(collection).doc(userID).set({
        'email': document['email'],
        'name': document['name'],
        'phone': document['phone']
      });
      FirebaseFirestore.instance.collection('newUsers').doc(userID).delete();
    } else {
      FirebaseFirestore.instance
          .collection(collection)
          .doc(userID)
          .set({'email': userEmail!});
    }
  }

  getNumberOfDoctor() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('doctors').get();
    numberOfDoctor = snap.size;
  }

  getNumberOfPatient() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('users').get();
    numberOfPatient = snap.size;
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
