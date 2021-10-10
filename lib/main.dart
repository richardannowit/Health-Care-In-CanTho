import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      title: "HealthCare",
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? Routes.USERINFORMATION
          : Routes.SPLASH,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
