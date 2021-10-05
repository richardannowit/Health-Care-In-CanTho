import 'package:get/get.dart';

import '../controllers/schedule_doctor_controller.dart';

class ScheduleDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleDoctorController>(
      () => ScheduleDoctorController(),
    );
  }
}
