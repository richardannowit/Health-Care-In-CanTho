import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';

class UserModel {
  String? email, name, phone, uid, sex;
  dynamic height, weight;
  Timestamp? dateOfBirth;
  DocumentReference? addressRef;
  AddressModel? address;
  DocumentReference? reference;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.phone,
      this.sex,
      this.weight,
      this.height,
      this.dateOfBirth,
      this.addressRef,
      this.reference});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
    this.name = json['name'];
    this.phone = json['phone'];
    this.sex = json['sex'];
    this.address = json['address'];
    this.height = json['height'];
    this.weight = json['weight'];
    this.dateOfBirth = json['dateofbirth'];
    this.reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    data['address'] = this.addressRef;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['dateofbirth'] = this.dateOfBirth;
    return data;
  }
}
