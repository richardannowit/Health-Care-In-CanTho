import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String? email, name, specialist, phone;
  double? rating;
  DocumentReference? addressRef;
  dynamic address;
  DocumentReference? reference;

  DoctorModel({
    this.email,
    this.name,
    this.specialist,
    this.phone,
    this.rating,
    this.addressRef,
    this.reference,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
    this.name = json['name'];
    this.address = json['address'];
    this.specialist = json['specialist'];
    this.phone = json['phone'];
    this.rating = json['rating'];
    this.reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['specialist'] = this.specialist;
    data['address'] = this.addressRef;
    data['phone'] = this.phone;
    data['rating'] = this.rating;
    return data;
  }
}
