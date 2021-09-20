import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';

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

  static Future<DoctorModel> getDoctorProfiles(String doctorId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorId)
        .get();
    if (snapshot.exists) {
      var doctorModel =
          DoctorModel.fromJson(snapshot.data() as Map<String, dynamic>);
      return doctorModel;
    }
    return DoctorModel();
  }

  static Future<List<AppointmentModel>> getAppointments(
      String patientEmail) async {
    CollectionReference appointmentRef =
        FirebaseFirestore.instance.collection('appointments_test');
    QuerySnapshot snapshot = await appointmentRef
        .orderBy('appointment_date')
        .where('patient', isEqualTo: patientEmail)
        .where('appointment_date', isGreaterThanOrEqualTo: new DateTime.now())
        .get();
    List<AppointmentModel> appointmentList = [];
    for (var element in snapshot.docs) {
      var appointment = element.data() as Map<String, dynamic>;
      DocumentSnapshot doctorRef = await appointment['doctor'].get();
      var doctorModel = new DoctorModel();
      if (doctorRef.exists) {
        doctorModel =
            DoctorModel.fromJson(doctorRef.data() as Map<String, dynamic>);
      }

      print(doctorRef.data());
      appointment['doctor'] = doctorModel;
      appointmentList.add(AppointmentModel.fromJson(appointment));
    }

    return appointmentList;
  }
}
