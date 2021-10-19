import 'package:get/get.dart';

import 'package:flutter_healthcare/app/modules/Signup/bindings/signup_binding.dart';
import 'package:flutter_healthcare/app/modules/Signup/views/signup_view.dart';
import 'package:flutter_healthcare/app/modules/appointments/bindings/appointments_binding.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/appointments_view.dart';
import 'package:flutter_healthcare/app/modules/booked_success/bindings/booked_success_binding.dart';
import 'package:flutter_healthcare/app/modules/booked_success/views/booked_success_view.dart';
import 'package:flutter_healthcare/app/modules/conversation/bindings/conversation_binding.dart';
import 'package:flutter_healthcare/app/modules/conversation/views/conversation_view.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/bindings/doctorinformation_binding.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/views/doctorinformation_view.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/bindings/doctorpersionalpage_binding.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/views/doctorpersionalpage_view.dart';
import 'package:flutter_healthcare/app/modules/doctors_list/bindings/doctor_list_binding.dart';
import 'package:flutter_healthcare/app/modules/doctors_list/views/doctor_list_view.dart';
import 'package:flutter_healthcare/app/modules/forgotpassword/bindings/forgotpassword_binding.dart';
import 'package:flutter_healthcare/app/modules/forgotpassword/views/forgotpassword_view.dart';
import 'package:flutter_healthcare/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_healthcare/app/modules/home/views/home_view.dart';
import 'package:flutter_healthcare/app/modules/home_doctor/bindings/home_doctor_binding.dart';
import 'package:flutter_healthcare/app/modules/home_doctor/views/home_doctor_view.dart';
import 'package:flutter_healthcare/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_healthcare/app/modules/login/views/login_view.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/bindings/make_appointment_binding.dart';
import 'package:flutter_healthcare/app/modules/make_appointment/views/make_appointment_view.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/bindings/schedule_doctor_binding.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/schedule_doctor_view.dart';
import 'package:flutter_healthcare/app/modules/splash/bindings/splash_binding.dart';
import 'package:flutter_healthcare/app/modules/splash/views/splash_view.dart';
import 'package:flutter_healthcare/app/modules/userinformation/bindings/userinformation_binding.dart';
import 'package:flutter_healthcare/app/modules/userinformation/views/userinformation_view.dart';

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
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
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
    GetPage(
      name: _Paths.DOCTORS_LIST,
      page: () => DoctorsListView(),
      binding: DoctorListBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENTS,
      page: () => AppointmentsView(),
      binding: AppointmentsBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASSWORD,
      page: () => ForgotpasswordView(),
      binding: ForgotpasswordBinding(),
    ),
    GetPage(
      name: _Paths.CONSERVATION,
      page: () => ConversationView(),
      binding: ConversationBinding(),
    ),
    GetPage(
      name: _Paths.HOME_DOCTOR,
      page: () => HomeDoctorView(),
      binding: HomeDoctorBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE_DOCTOR,
      page: () => ScheduleDoctorView(),
      binding: ScheduleDoctorBinding(),
    ),
    GetPage(
      name: _Paths.DOCTORPERSIONALPAGE,
      page: () => DoctorpersionalpageView(),
      binding: DoctorpersionalpageBinding(),
    ),
    GetPage(
      name: _Paths.MAKE_APPOINTMENT,
      page: () => MakeAppointmentView(),
      binding: MakeAppointmentBinding(),
    ),
    GetPage(
      name: _Paths.BOOKED_SUCCESS,
      page: () => BookedSuccessView(),
      binding: BookedSuccessBinding(),
    ),
    GetPage(
      name: _Paths.USERINFORMATION,
      page: () => UserinformationView(),
      binding: UserinformationBinding(),
    ),
    GetPage(
      name: _Paths.DOCTORINFORMATION,
      page: () => DoctorinformationView(),
      binding: DoctorinformationBinding(),
    ),
  ];
}
