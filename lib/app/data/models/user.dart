import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';

class UserModel {
  String? email, name, phone, uid;
  dynamic height, weight;
  DocumentReference? addressRef;
  AddressModel? address;
  DocumentReference? reference;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.phone,
      this.addressRef,
      this.reference});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
    this.name = json['name'];
    this.phone = json['phone'];
    this.address = json['address'];
    this.height = json['height'];
    this.weight = json['weight'];
    this.reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['height'] = this.height;
    data['weight'] = this.weight;
    return data;
  }
}
