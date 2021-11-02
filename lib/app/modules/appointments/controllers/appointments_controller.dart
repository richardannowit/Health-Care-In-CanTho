import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/constants.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointment.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointments.dart';
import 'package:get/get.dart';

class AppointmentsController extends GetxController {
  final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  RxString less = "Z".obs;
  RxString greater = "A".obs;
  String statusFilter = "All";
  CollectionReference<Map<String, dynamic>> dbUserRef =
      FirebaseFirestore.instance.collection('doctors');
  CollectionReference<Map<String, dynamic>> dbAppRef =
      FirebaseFirestore.instance.collection('appointments');

  Stream<List<Appointment>> getData(dynamic less, dynamic greater) async* {
    Constants.myName =
        (await HelperFunctions.getUserEmailSharedPreference()) ?? '';
    var appointmentsStream;
    appointmentsStream = FirebaseFirestore.instance
        .collection('appointments')
        // .orderBy('appointment_date')
        .where('patient', isEqualTo: userEmail)
        .where('status', isLessThanOrEqualTo: less)
        .where('status', isGreaterThanOrEqualTo: greater)
        .snapshots();
    List<Appointment> appointments = [];
    await for (var appointmentSnapshot in appointmentsStream) {
      appointments.clear();
      for (var appointmentDoc in appointmentSnapshot.docs) {
        Appointment appointment;
        appointment = new Appointment(appointmentDoc['status']);
        Timestamp timeStamp = appointmentDoc['appointment_date'];
        appointment.setDateTime(timeStamp);
        if (appointmentDoc['doctor'] != null) {
          DocumentSnapshot doctorDoc = await appointmentDoc['doctor'].get();
          appointment.setDoctorName(doctorDoc['name']);
          appointment.setSpecialist(doctorDoc['specialist']);
          appointment.setDoctorEmail(doctorDoc['email']);
        }
        appointments.add(appointment);
        sortAppointment(appointments);
      }
      yield appointments;
    }
  }
}
