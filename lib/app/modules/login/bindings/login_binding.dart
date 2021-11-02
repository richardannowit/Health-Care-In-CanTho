import 'package:flutter_healthcare/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<HomeView>(
      () => HomeView(),
    );
  }
}
