import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  RxBool isAuth = false.obs;
  RxBool initializedFirebase = false.obs;
  //final currentUser = localUser.User().obs;

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

  void handleSignIn() {
    bool? isValid = formKey.currentState?.validate();
    if (isValid != null && isValid) {
      formKey.currentState?.save();

      Get.toNamed(Routes.HOME);
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Get.offAllNamed(Routes.HOME);
  }
}
