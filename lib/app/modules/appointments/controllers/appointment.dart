import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  late String doctorName;
  late String status;
  late Timestamp dateTime;
  late String specialist;

  Appointment(String status) {
    switch (status) {
      case "active":
        this.status = "Active";
        break;
      case "waiting":
        this.status = "Waiting";
        break;
      default:
        this.status = "Done";
    }
  }
  setDoctorName(String name) {
    doctorName = name;
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
