import 'package:get/get.dart';

import 'package:flutter_healthcare/app/modules/Signup/bindings/signup_binding.dart';
import 'package:flutter_healthcare/app/modules/Signup/views/signup_view.dart';
import 'package:flutter_healthcare/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_healthcare/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNUP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
  ];
}
