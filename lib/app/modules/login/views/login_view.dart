import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 24, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/bs_login.png'),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Healthcare',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            _buildLoginForm(context),
          ],
        ),
      ),
    ));
  }

  Color primaryColor() {
    return Color.fromARGB(255, 252, 217, 133);
  }

  Form _buildLoginForm(BuildContext context) {
    return Form(
        key: controller.formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24, 60, 24, 0),
              child: PhysicalModel(
                color: Colors.white,
                elevation: 6,
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8.0, right: 40),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email...',
                            icon: Icon(
                              Icons.email,
                              color: primaryColor(),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor(),
                              ),
                            ),
                          ),
                          validator: (value) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!)
                                ? null
                                : "Please enter a valid email";
                          },
                          onSaved: (value) {
                            controller.email = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 40),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password...',
                            icon: Icon(
                              Icons.lock,
                              color: primaryColor(),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor(),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'Please enter the correct password!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.password = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 20, 32, 8),
                        child: InkWell(
                          onTap: () => controller.handleSignIn(context),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: primaryColor(),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: primaryColor(),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
              child: InkWell(
                onTap: () => controller.signInWithGoogle(),
                child: PhysicalModel(
                  color: Colors.grey,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: primaryColor(),
                    ),
                    child: Text(
                      'SIGN IN WITH GOOGLE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account? ",
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      color: primaryColor(),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
