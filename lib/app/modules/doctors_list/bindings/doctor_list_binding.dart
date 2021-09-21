import 'package:flutter_healthcare/app/data/models/district.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

import '../controllers/doctor_list_controller.dart';

class DoctorListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorListController>(
      () => DoctorListController(),
    );
    Get.lazyPut<District>(
      () => District(),
    );
    Get.lazyPut<DatabaseMethods>(
      () => DatabaseMethods(),
    );
  }
}
