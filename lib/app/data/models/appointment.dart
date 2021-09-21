import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';

class AppointmentModel {
  String? patient, status;
  Timestamp? appointment_date;
  DocumentReference? doctorRef;
  DoctorModel? doctor;
  DocumentReference? reference;

  AppointmentModel({
    this.doctorRef,
    this.patient,
    this.status,
    this.appointment_date,
    this.reference,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    this.doctor = json['doctor'];
    this.patient = json['patient'];
    this.status = json['status'];
    this.appointment_date = json['appointment_date'];
    this.reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor'] = this.doctorRef;
    data['patient'] = this.patient;
    data['status'] = this.status;
    data['appointment_date'] = this.appointment_date;
    data['reference'] = this.reference;
    return data;
  }
}