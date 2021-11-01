import 'package:get/get.dart';

import '../controllers/appointments_doctor_controller.dart';

class AppointmentsDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentsDoctorController>(
      () => AppointmentsDoctorController(),
    );
  }
}
