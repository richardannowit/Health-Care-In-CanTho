import 'package:flutter_healthcare/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_healthcare/app/modules/home/views/home_view.dart';
import 'package:flutter_healthcare/app/modules/login/controllers/login_controller.dart';
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
