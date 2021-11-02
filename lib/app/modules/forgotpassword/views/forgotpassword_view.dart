import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_appbar.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:get/get.dart';
import '../controllers/forgotpassword_controller.dart';

class ForgotpasswordView extends GetView<ForgotpasswordController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textFeildBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Background(height: MediaQuery.of(context).size.height),
            Column(
              children: [
                CustomAppBar(title: ''),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      height: 450,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: CircleAvatar(
                              child: Image(
                                image:
                                    AssetImage('assets/images/avt_doctor.png'),
                              ),
                            ),
                          ),
                          Text(
                            'Quên mật khẩu?',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Vui lòng nhập email của bạn',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  child: TextFormField(
                                    onSaved: (value) {
                                      controller.email = value!;
                                      if (!controller.success) {
                                        controller.forgotPassword();
                                      }
                                      Get.snackbar('Success!',
                                          'A password recovery message has been sent to your email');
                                    },
                                    validator: (value) {
                                      if (!GetUtils.isEmail(value!)) {
                                        return 'Hãy nhập chính xác email của bạn';
                                      }

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          color: greyColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      prefixIcon:
                                          Icon(Icons.person, color: greyColor),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                      border: textFeildBorder,
                                      enabledBorder: textFeildBorder,
                                      focusedBorder: textFeildBorder,
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: secondaryColor)),
                                      disabledBorder: textFeildBorder,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                              width: 300,
                              height: 50,
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                _formKey.currentState!.save();
                              },
                              text: 'Xác nhận')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
