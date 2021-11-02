import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:flutter_healthcare/app/modules/userinformation/views/constants.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class UpdateUserInformationView extends StatelessWidget {
  UpdateUserInformationView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Center(
                child: Stack(
              children: [
                Background(height: MediaQuery.of(context).size.height),
                buildView(context)
              ],
            ))));
  }

  Widget buildView(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: 112,
            height: 112,
            child: CircleAvatar(
              child: Image(
                image: AssetImage('assets/images/avt_doctor.png'),
              ),
            ),
          ),
          Container(
            width: 300,
            child: TextFormField(
              onSaved: (value) {},
              validator: (value) {
                if (!GetUtils.isUsername(value!)) {
                  return 'Hãy nhập chính xác tên của bạn';
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: 'Nguyen Dang Khoa',
                hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: primaryColor)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: primaryColor)),
              ),
            ),
          ),
          Text(
            'khoa@gmail.com',
            style: informationText,
          ),
          Row(
            children: [
              Text(
                'Giới tính',
              ),
              SizedBox(
                height: 30,
                child: Container(
                  width: 250,
                  child: TextFormField(
                    onSaved: (value) {},
                    validator: (value) {
                      if (!GetUtils.isEmail(value!)) {
                        return 'Hãy nhập chính xác tên của bạn';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Nguyen Dang Khoa',
                      hintStyle: TextStyle(
                          color: greyColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w800),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: secondaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: primaryColor)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          CustomButton(
              width: 100,
              height: 50,
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                _formKey.currentState!.save();
              },
              text: 'Xong')
        ],
      ));
}
