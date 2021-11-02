import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  late String doctorName;
  late String doctorEmail;
  late String status;
  late Timestamp dateTime;
  late String specialist;

  Appointment(String status) {
    this.status = status;
  }
  setDoctorName(String name) {
    doctorName = name;
  }

  setDoctorEmail(String email) {
    doctorEmail = email;
  }

  setDateTime(Timestamp dateTime) {
    this.dateTime = dateTime;
  }

  setSpecialist(String specialist) {
    this.specialist = specialist;
  }

  String getStatus() {
    return status;
  }
}
