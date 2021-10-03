import 'package:get/get.dart';

import '../controllers/doctorpersionalpage_controller.dart';

class DoctorpersionalpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorpersionalpageController>(
      () => DoctorpersionalpageController(),
    );
  }
}
