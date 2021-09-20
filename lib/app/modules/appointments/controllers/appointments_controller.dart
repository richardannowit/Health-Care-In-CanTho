import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointment.dart';
import 'package:get/get.dart';

class AppointmentsController extends GetxController {
  RxList appointmentList = [].obs;
  final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  CollectionReference<Map<String, dynamic>> dbUserRef =
      FirebaseFirestore.instance.collection('doctors');
  CollectionReference<Map<String, dynamic>> dbAppRef =
      FirebaseFirestore.instance.collection('appointments');

  getAppointments() async {
    QuerySnapshot snapshot =
        await dbAppRef.where('patient', isEqualTo: userEmail).get();
    snapshot.docs.forEach((doc) async {
      try {
        Appointment currentAppointment =
            new Appointment(doc['doctor'], doc['status']);
        Timestamp timestamp = doc['appointment_date'];
        DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(
            timestamp.microsecondsSinceEpoch);
        currentAppointment.setDateTime(dateTime);
        QuerySnapshot doctorSnapshot =
            await dbUserRef.where('email', isEqualTo: doc['doctor']).get();
        doctorSnapshot.docs.forEach((doc) {
          currentAppointment.setDoctorName(doc['name']);
        });
        appointmentList.add(currentAppointment);
      } on StateError catch (e) {
        print('No feild exists!');
      }
    });
  }
}
