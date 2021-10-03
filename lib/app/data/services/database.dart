import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_healthcare/app/data/models/district.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/models/review.dart';
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
      user['reference'] = snapshot.reference;

      AddressModel addressModel = new AddressModel(name: 'NULL');
      if (user.containsKey('address')) {
        DocumentSnapshot addressRef = await user['address'].get();
        if (addressRef.exists) {
          final addressJson = addressRef.data() as Map<String, dynamic>;
          addressJson['reference'] = addressRef.reference;
          addressModel = AddressModel.fromJson(addressJson);
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
    QuerySnapshot snapshot = await _firestore
        .collection('appointments')
        .orderBy('appointment_date')
        .where('patient', isEqualTo: patientEmail)
        .where('appointment_date', isGreaterThanOrEqualTo: new DateTime.now())
        .get();

    List<AppointmentModel> appointmentList = [];
    for (var element in snapshot.docs) {
      var appointment = element.data() as Map<String, dynamic>;
      appointment['reference'] = element.reference;

      var doctorModel = new DoctorModel();

      /* Query doctor */
      if (appointment.containsKey('doctor')) {
        DocumentSnapshot doctorRef = await appointment['doctor'].get();
        if (doctorRef.exists) {
          final doctorJson = doctorRef.data() as Map<String, dynamic>;
          doctorJson['reference'] = doctorRef.reference;
          doctorModel = DoctorModel.fromJson(doctorJson);
        }
      }

      appointment['doctor'] = doctorModel;

      appointmentList.add(AppointmentModel.fromJson(appointment));
    }

    return appointmentList;
  }

  static Future<List<DoctorModel>> getDoctors(
      [DocumentReference? userAddressRef]) async {
    QuerySnapshot snapshot;
    if (userAddressRef != null) {
      snapshot = await _firestore
          .collection('doctors')
          .where('address', isEqualTo: userAddressRef)
          .get();
    } else {
      snapshot = await _firestore.collection('doctors').get();
    }
    List<DoctorModel> doctorList = [];
    for (var element in snapshot.docs) {
      final doctor = element.data() as Map<String, dynamic>;
      doctor['reference'] = element.reference;
      doctor['docId'] = element.id;

      dynamic addressModel = new AddressModel(name: "NULL");
      /* Query address*/
      if (doctor.containsKey('address')) {
        DocumentSnapshot addressRef = await doctor['address'].get();
        if (addressRef.exists) {
          final addressJson = addressRef.data() as Map<String, dynamic>;
          addressJson['reference'] = addressRef.reference;
          addressModel = AddressModel.fromJson(addressJson);
        }
      }
      doctor['address'] = addressModel;

      doctorList.add(DoctorModel.fromJson(doctor));
    }

    return doctorList;
  }

  static Future<DocumentReference> getDistrictRefFromDistrictName(
      String addressName) async {
    QuerySnapshot snapshot = await _firestore
        .collection('districts')
        .where('name', isEqualTo: addressName)
        .get();
    DocumentSnapshot address = snapshot.docs.first;
    DocumentReference addressRef = address.reference;
    return addressRef;
  }

  Future<List<DoctorModel>> getDoctorsByDistrict(String district) async {
    var doctors = new List<DoctorModel>.empty(growable: true);
    DocumentReference addressRef =
        await getDistrictRefFromDistrictName(district);
    // dynamic addressName = await addressRef.get();
    // print(addressName.data()['name']);
    DocumentSnapshot address = await addressRef.get();
    dynamic addressModel = new AddressModel(name: "NULL");
    final addressJson = address.data() as Map<String, dynamic>;
    addressJson['reference'] = address.reference;
    addressModel = AddressModel.fromJson(addressJson);
    CollectionReference doctorRef =
        FirebaseFirestore.instance.collection('doctors');

    final snapshot =
        await doctorRef.where('address', isEqualTo: addressRef).get();
    snapshot.docs.forEach((element) {
      var doctor = DoctorModel.fromJson(element.data() as Map<String, dynamic>);
      doctor.docId = element.id;
      doctor.reference = element.reference;
      doctor.address = addressModel;
      doctors.add(doctor);
    });
    return doctors;
  }

  Future<List<AddressModel>> getDistricts() async {
    var districts = new List<AddressModel>.empty(growable: true);
    CollectionReference districtRef =
        FirebaseFirestore.instance.collection('districts');

    final snapshot = await districtRef.get();
    snapshot.docs.forEach((element) {
      var district =
          AddressModel.fromJson(element.data() as Map<String, dynamic>);
      district.reference = element.reference;
      districts.add(district);
    });
    return districts;
  }

  static Future<List<ReviewModel>> getReviews(String docId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('doctors')
        .doc(docId)
        .collection('reviews')
        .get();
    List<ReviewModel> reviewList = [];
    for (var element in snapshot.docs) {
      var review = element.data() as Map<String, dynamic>;
      ReviewModel reviewModel = new ReviewModel.fromJson(review);
      if (review.containsKey('user')) {
        DocumentSnapshot userRef = await review['user'].get();
        reviewModel.userName = userRef['name'];
      }
      reviewList.add(reviewModel);
    }
    return reviewList;
  }

  static Future<DocumentReference<Object?>> getUserRef(String userEmail) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
    return snapshot.docs.first.reference;
  }

  static upLoadReview(reviewData, String docId) {
    _firestore
        .collection('doctors')
        .doc(docId)
        .collection('reviews')
        .add(reviewData);
  }
}
