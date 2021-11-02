import 'package:cloud_firestore/cloud_firestore.dart';

class District {
  String name = '';
  DocumentReference? reference;

  District();

  District.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
