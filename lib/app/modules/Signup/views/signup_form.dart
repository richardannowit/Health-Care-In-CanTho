import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_textformfield.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:flutter_healthcare/app/modules/Signup/views/constants.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
  }) : super(key: key);

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: controller.signupFormKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        // decoration: formStyle,
        child: Column(
          children: [
            buildNameFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildEmailFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildPhoneFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildPasswordFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            buildConfirmPasswordFormField(),
            SizedBox(
              height: size.height * 0.03,
            ),
            CustomButton(
              width: size.width * 0.7,
              height: 50,
              onPressed: () {
                controller.checkSignUp();
              },
              text: "Đăng ký",
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bạn đã có tài khoản? ",
                  style: TextStyle(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 14, color: primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      decoration: buildDecorationTextFormField(
        hintText: "Họ và tên",
        icon: Icons.person,
      ),
      keyboardType: TextInputType.name,
      onSaved: (value) {
        controller.name = value!;
      },
      validator: (value) {
        return controller.validateName(value!);
      },
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: buildDecorationTextFormField(
        hintText: "Email",
        icon: Icons.email,
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        controller.email = value!;
      },
      validator: (value) {
        return controller.validateEmail(value!);
      },
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      decoration: buildDecorationTextFormField(
        hintText: "Số điện thoại",
        icon: Icons.phone,
      ),
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        controller.phone = value!;
      },
      validator: (value) {
        return controller.validatePhone(value!);
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      key: controller.passKey,
      decoration: buildDecorationTextFormField(
        hintText: "Mật khẩu",
        icon: Icons.lock,
      ),
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        controller.password = value!;
      },
      validator: (value) {
        return controller.validatePassword(value!);
      },
      obscureText: true,
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      decoration: buildDecorationTextFormField(
        hintText: "Nhập lại mật khẩu",
        icon: Icons.lock,
      ),
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        controller.confirmPassword = value!;
      },
      validator: (value) {
        return controller.validateConfirmPassword(value!);
      },
      obscureText: true,
    );
  }
}
