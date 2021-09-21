import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String? name;
  DocumentReference? reference;

  AddressModel({
    this.name,
    this.reference,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
