import 'package:get/get.dart';

import '../controllers/make_appointment_controller.dart';

class MakeAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeAppointmentController>(
      () => MakeAppointmentController(),
    );
  }
}
