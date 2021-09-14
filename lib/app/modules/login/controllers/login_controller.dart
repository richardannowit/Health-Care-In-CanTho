import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/services/auth.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/modules/login/views/processing_dialog.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  bool userIsLoggedIn = false;

  RxBool isAuth = false.obs;
  RxBool initializedFirebase = false.obs;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot? snapshotUserInfo;

  @override
  void onInit() {
    super.onInit();
    _initFirebase();
  }

  @override
  void onReady() {
    super.onReady();

    once(
      initializedFirebase,
      (_) => _initUserSession(),
      condition: () => initializedFirebase.isTrue,
    );
    once(
      initializedFirebase,
      (_) => _listenAuthState(),
      condition: () => initializedFirebase.isTrue,
    );
  }

  @override
  void onClose() {}

  void _initFirebase() async {
    try {
      await Firebase.initializeApp();
      initializedFirebase.value = true;
    } catch (e) {
      print(e);
    }
  }

  void _initUserSession() {
    try {
      isAuth.value = FirebaseAuth.instance.currentUser != null;
    } catch (e) {
      print(e);
    }
  }

  void _listenAuthState() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        isAuth.value = user != null;
      });
    } catch (e) {
      print(e);
    }
  }

  void handleSignIn(BuildContext context) {
    bool? isValid = formKey.currentState?.validate();
    if (isValid != null && isValid) {
      formKey.currentState?.save();

      HelperFunctions.saveUserEmailSharedPreference(email.toString());

      databaseMethods.getUserByUserEmail(email).then((valueGet) {
        snapshotUserInfo = valueGet;
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo?.docs[0]["name"]);
      });

      isLoading = true;

      authMethods
          .signInWithEmailAndPassword(email.toString(), password.toString())
          .then((value) {
        if (value != null) {
          databaseMethods.getUserByUserEmail(email.toString());
          HelperFunctions.saveUserLoggedInSharedPreference(true);

          Get.offAllNamed(Routes.HOME);
        } else {
          final snackBar = SnackBar(
            backgroundColor: Color.fromARGB(255, 252, 217, 133),
            content: const Text(
              'Email or Password is incorrect!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  Future<void> signInWithGoogle() async {
    CustomFullScreenDialog.showDialog();
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      CustomFullScreenDialog.cancelDialog();
      Get.offAllNamed(Routes.LOGIN);
    } else {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      CustomFullScreenDialog.cancelDialog();
      Get.offAllNamed(Routes.HOME);
    }
  }
}
