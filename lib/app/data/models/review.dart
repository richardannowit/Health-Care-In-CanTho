import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? content, userName;
  double? score;
  Timestamp? date;
  DocumentReference? userRef;

  ReviewModel({this.content, this.score, this.date, this.userRef});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    this.content = json['content'];
    this.date = json['date'];
    this.score =
        double.parse(json['score'] == null ? '0' : json['score'].toString());
    this.userRef = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['date'] = this.date;
    data['score'] = this.score;
    data['user'] = this.userRef;
    return data;
  }
}
