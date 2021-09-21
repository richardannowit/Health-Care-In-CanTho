import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointment.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointments.dart';
import 'package:get/get.dart';

class AppointmentsController extends GetxController {
  final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  String less = "z";
  String greater = "a";
  String statusFilter = "All";
  CollectionReference<Map<String, dynamic>> dbUserRef =
      FirebaseFirestore.instance.collection('doctors');
  CollectionReference<Map<String, dynamic>> dbAppRef =
      FirebaseFirestore.instance.collection('appointments');

  Stream<List<Appointment>> getData() async* {
    var appointmentsStream;
    appointmentsStream = FirebaseFirestore.instance
        .collection('appointments')
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
        appointment.setDateTime(DateTime.fromMicrosecondsSinceEpoch(
            timeStamp.microsecondsSinceEpoch));
        if (appointmentDoc['doctor'] != null) {
          DocumentSnapshot doctorDoc = await appointmentDoc['doctor'].get();
          appointment.setDoctorName(doctorDoc['name']);
          appointment.setSpecialist(doctorDoc['specialist']);
        }
        appointments.add(appointment);
        sortAppointment(appointments);
      }
      yield appointments;
    }
  }
}
