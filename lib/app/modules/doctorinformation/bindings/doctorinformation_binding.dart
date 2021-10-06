import 'package:get/get.dart';

import '../controllers/doctorinformation_controller.dart';

class DoctorinformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorinformationController>(
      () => DoctorinformationController(),
    );
  }
}
