import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_healthcare/app/data/models/district.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';

class DatabaseMethods {
  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  Future<List<Doctor>> getDoctorsByDistrict(String district) async {
    var doctors = new List<Doctor>.empty(growable: true);
    CollectionReference doctorRef = FirebaseFirestore.instance
        .collection('districts')
        .doc(district)
        .collection('doctors');

    final snapshot = await doctorRef.get();
    snapshot.docs.forEach((element) {
      var doctor = Doctor.fromJson(element.data() as Map<String, dynamic>);
      doctor.docId = element.id;
      doctor.reference = element.reference;
      doctors.add(doctor);
    });
    return doctors;
  }

  Future<List<District>> getDistricts() async {
    var districts = new List<District>.empty(growable: true);
    CollectionReference districtRef =
        FirebaseFirestore.instance.collection('districts');

    final snapshot = await districtRef.get();
    snapshot.docs.forEach((element) {
      var district = District.fromJson(element.data() as Map<String, dynamic>);
      district.reference = element.reference;
      districts.add(district);
    });
    return districts;
  }
}
