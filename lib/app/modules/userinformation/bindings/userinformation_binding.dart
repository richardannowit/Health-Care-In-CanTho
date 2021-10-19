import 'package:get/get.dart';

import '../controllers/userinformation_controller.dart';

class UserinformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserinformationController>(
      () => UserinformationController(),
    );
  }
}
