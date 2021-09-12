import 'package:flutter_healthcare/app/modules/splash/bindings/splash_binding.dart';
import 'package:flutter_healthcare/app/modules/splash/views/splash_view.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
