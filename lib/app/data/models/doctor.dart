import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String email = '';
  String name = '';
  String docId = '';
  String phone = '';
  String specialist = '';
  double rating = 0.0;

  DocumentReference? reference;

  Doctor();

  Doctor.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    specialist = json['specialist'];
    rating =
        double.parse(json['rating'] == null ? '0' : json['rating'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['specialist'] = this.specialist;
    data['rating'] = this.rating;

    return data;
  }
}
