import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('name',
            isGreaterThanOrEqualTo: username,
            isLessThanOrEqualTo: username + '\uf8ff')
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
  }

  Future<Map<String, dynamic>> getUserByUID(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return data;
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  Stream<List<AppointmentModel>> appointmentStream() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .orderBy('appointment_date')
        .limit(4)
        .snapshots()
        .map((QuerySnapshot query) {
      List<AppointmentModel> _appointmentsList = [];
      query.docs.forEach((appointment) {
        _appointmentsList
            .add(AppointmentModel.fromDocumentSnapshot(appointment));
      });
      return _appointmentsList;
    });
  }
}
