import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/services/auth.dart';
import 'package:flutter_healthcare/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            Text(FirebaseAuth.instance.currentUser!.email.toString()),
            InkWell(
              onTap: () {
                AuthMethods().signOut();
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                Get.offAllNamed(Routes.LOGIN);
              },
              child: Text(
                'SIGN OUT',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
