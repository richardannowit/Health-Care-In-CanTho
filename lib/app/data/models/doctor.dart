import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String? docId;
  String? email, name, specialist, phone, about, centeraddress;
  double? rating;
  DocumentReference? addressRef;
  dynamic address;
  DocumentReference? reference;

  DoctorModel({
    this.docId,
    this.email,
    this.name,
    this.specialist,
    this.phone,
    this.rating,
    this.addressRef,
    this.reference,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    this.docId = json['docId'];
    this.email = json['email'];
    this.name = json['name'];
    this.address = json['address'];
    this.specialist = json['specialist'];
    this.phone = json['phone'];
    this.about = json['about'];
    this.centeraddress = json['centeraddress'];
    rating =
        double.parse(json['rating'] == null ? '0' : json['rating'].toString());
    this.reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['specialist'] = this.specialist;
    data['address'] = this.addressRef;
    data['phone'] = this.phone;
    data['about'] = this.about;
    data['centeraddress'] = this.centeraddress;
    data['rating'] = this.rating;
    return data;
  }
}
