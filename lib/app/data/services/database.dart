import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';

class DatabaseMethods {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getUserByUsername(String username) async {
    return await _firestore
        .collection('users')
        .where('name',
            isGreaterThanOrEqualTo: username,
            isLessThanOrEqualTo: username + '\uf8ff')
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await _firestore
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
  }

  Future<UserModel> getUserByUID(String uid) async {
    var snapshot = await _firestore.collection('users').doc(uid).get();

    if (snapshot.exists) {
      Map<String, dynamic> user = snapshot.data() as Map<String, dynamic>;
      AddressModel addressModel = new AddressModel(name: 'NULL');
      if (user.containsKey('address')) {
        DocumentSnapshot addressRef = await user['address'].get();
        if (addressRef.exists) {
          addressModel =
              AddressModel.fromJson(addressRef.data() as Map<String, dynamic>);
        }
      }
      user['address'] = addressModel;

      return UserModel.fromJson(user);
    }

    return UserModel();
  }

  uploadUserInfo(userMap) {
    _firestore.collection('users').add(userMap);
  }

  static Future<DoctorModel> getDoctorProfiles(String doctorId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('doctors').doc(doctorId).get();
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
        _firestore.collection('appointments_test');
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
      appointment['doctor'] = doctorModel;
      appointmentList.add(AppointmentModel.fromJson(appointment));
    }

    return appointmentList;
  }

  static Future<List<DoctorModel>> getDoctors() async {
    CollectionReference doctorRef = _firestore.collection('doctors');
    QuerySnapshot snapshot = await doctorRef
        // .orderBy('appointment_date')
        // .where('patient', isEqualTo: patientEmail)
        // .where('appointment_date', isGreaterThanOrEqualTo: new DateTime.now())
        .get();
    List<DoctorModel> doctorList = [];
    for (var element in snapshot.docs) {
      var doctor = element.data() as Map<String, dynamic>;
      var addressModel = new AddressModel(name: "NULL");
      DocumentSnapshot addressRef = await doctor['address'].get();
      if (addressRef.exists) {
        addressModel =
            AddressModel.fromJson(addressRef.data() as Map<String, dynamic>);
      }
      doctor['address'] = addressModel;
      print(doctor['address'].name);
      doctorList.add(DoctorModel.fromJson(doctor));
    }

    return doctorList;
  }
}
