import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String? doctor, patient, status;
  Timestamp? appointment_date;

  AppointmentModel(
    this.doctor,
    this.patient,
    this.status,
    this.appointment_date,
  );

  AppointmentModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    doctor = data["doctor"];
    patient = data["patient"];
    status = data["status"];
    appointment_date = data["appointment_date"];
  }
}
