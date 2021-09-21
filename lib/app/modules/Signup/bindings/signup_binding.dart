import 'package:flutter_healthcare/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );
    Get.lazyPut<LoginView>(
      () => LoginView(),
    );
  }
}
