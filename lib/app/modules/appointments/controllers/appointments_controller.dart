import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/constants.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointments.dart';
import 'package:get/get.dart';

class AppointmentsController extends GetxController {
  final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  RxString less = "Z".obs;
  RxString greater = "A".obs;
  String statusFilter = "All";
  CollectionReference<Map<String, dynamic>> dbUserRef =
      FirebaseFirestore.instance.collection('doctors');
  CollectionReference<Map<String, dynamic>> dbAppRef =
      FirebaseFirestore.instance.collection('appointments');

  Stream<List<AppointmentModel>> getData(dynamic less, dynamic greater) async* {
    Constants.myName =
        (await HelperFunctions.getUserEmailSharedPreference()) ?? '';
    var appointmentsStream;
    appointmentsStream = FirebaseFirestore.instance
        .collection('appointments')
        // .orderBy('appointment_date')
        .where('patient', isEqualTo: userEmail)
        .where('status', isLessThanOrEqualTo: less)
        .where('status', isGreaterThanOrEqualTo: greater)
        .snapshots();
    List<AppointmentModel> appointments = [];
    await for (var appointmentSnapshot in appointmentsStream) {
      appointments.clear();
      for (var appointmentDoc in appointmentSnapshot.docs) {
        var appointment = appointmentDoc.data() as Map<String, dynamic>;
        appointment['reference'] = appointmentDoc.reference;

        var doctorModel = new DoctorModel();

        /* Query doctor */
        if (appointment.containsKey('doctor')) {
          DocumentSnapshot doctorRef = await appointment['doctor'].get();
          if (doctorRef.exists) {
            final doctorJson = doctorRef.data() as Map<String, dynamic>;
            doctorJson['reference'] = doctorRef.reference;
            doctorJson['docId'] = doctorRef.id;
            doctorModel = DoctorModel.fromJson(doctorJson);
          }
        }

        appointment['doctor'] = doctorModel;

        appointments.add(AppointmentModel.fromJson(appointment));
      }
      sortAppointment(appointments);
      yield appointments;
    }
  }

  Future<void> cancelAppointment(AppointmentModel app) async {
    bool isCancel = await DatabaseMethods.deleteAppointment(app);
    if (!isCancel) {
      Get.snackbar(
        "Cancel appointment error!",
        "You can't delete this appointment.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }
}
