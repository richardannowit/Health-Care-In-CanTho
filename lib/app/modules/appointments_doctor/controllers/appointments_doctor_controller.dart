import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class AppointmentsDoctorController extends GetxController {
  // final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  RxString less = "z".obs;
  RxString greater = "a".obs;
  String statusFilter = "All";

  CollectionReference<Map<String, dynamic>> dbUserRef =
      FirebaseFirestore.instance.collection('doctors');
  CollectionReference<Map<String, dynamic>> dbAppRef =
      FirebaseFirestore.instance.collection('appointments');

  Stream<List<AppointmentModel>> getDoctorData(
      dynamic less, dynamic greater) async* {
    var appointmentsStream;
    var doctorRef = await DatabaseMethods.getDoctorRef(
        FirebaseAuth.instance.currentUser!.uid);
    appointmentsStream = FirebaseFirestore.instance
        .collection('appointments')
        .where('doctor', isEqualTo: doctorRef)
        .snapshots();
    List<AppointmentModel> appointments = [];
    await for (var appointmentSnapshot in appointmentsStream) {
      appointments.clear();
      for (var appointmentDoc in appointmentSnapshot.docs) {
        var appointment = appointmentDoc.data() as Map<String, dynamic>;
        var doctorModel = new DoctorModel();
        appointment['doctor'] = doctorModel;
        var appointmetModel = AppointmentModel.fromJson(appointment);
        if (appointment.containsKey('patient')) {
          var userRefefence =
              await DatabaseMethods.getUserRef(appointment['patient']);
          DocumentSnapshot userRef = await userRefefence.get();
          if (userRef.exists) {
            appointmetModel.name = userRef['name'];
          }
        }
        appointments.add(appointmetModel);
      }
      yield appointments;
    }
  }

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
}