import 'package:flutter_healthcare/app/modules/home_doctor/controllers/home_doctor_controller.dart';
import 'package:get/get.dart';

import '../controllers/doctorinformation_controller.dart';

class DoctorinformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorinformationController>(
      () => DoctorinformationController(),
    );
    Get.lazyPut<HomeDoctorController>(
      () => HomeDoctorController(),
    );
  }
}
