import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/controllers/doctorinformation_controller.dart';
import 'package:get/get.dart';

import 'constants.dart';

class UpdateView extends StatelessWidget {
  UpdateView({Key? key}) : super(key: key);

  final DoctorinformationController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textFeildBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor));

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
            body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Background(height: MediaQuery.of(context).size.height),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 26),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      color: primaryColor,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          height: 700,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Text(
                                  'Nhập vào thông tin',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 26,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Tên: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initName,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  border: textFeildBorder,
                                  enabledBorder: textFeildBorder,
                                  focusedBorder: textFeildBorder,
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          BorderSide(color: secondaryColor)),
                                  disabledBorder: textFeildBorder,
                                  hintText: controller.newDoctor.name,
                                  hintStyle: textStyle,
                                ),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.name = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.name ==
                                          'VD: Võ Tứ Thiên')
                                    return 'Hãy nhập vào tên!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Số điện thoại: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initPhone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  border: textFeildBorder,
                                  enabledBorder: textFeildBorder,
                                  focusedBorder: textFeildBorder,
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          BorderSide(color: secondaryColor)),
                                  disabledBorder: textFeildBorder,
                                  hintText: controller.newDoctor.phone,
                                  hintStyle: textStyle,
                                ),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.phone = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.phone ==
                                          'VD: 0812305346')
                                    return 'Hãy nhập vào số điện thoại!';
                                  if (value != '' &&
                                      !GetUtils.isPhoneNumber(value!))
                                    return 'Số điện thoại không hợp lệ!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.architecture,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Chuyên khoa: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initSpecialist,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    border: textFeildBorder,
                                    enabledBorder: textFeildBorder,
                                    focusedBorder: textFeildBorder,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor)),
                                    disabledBorder: textFeildBorder,
                                    hintText: controller.newDoctor.specialist,
                                    hintStyle: textStyle),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.specialist = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.specialist ==
                                          'VD: Tim mạch')
                                    return 'Hãy nhập vào chuyên khoa!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.app_registration_rounded,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Giới thiệu: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initAbout,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    border: textFeildBorder,
                                    enabledBorder: textFeildBorder,
                                    focusedBorder: textFeildBorder,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor)),
                                    disabledBorder: textFeildBorder,
                                    hintText: controller.newDoctor.about,
                                    hintStyle: textStyle),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.about = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.about ==
                                          'VD: Bác sĩ nổi tiếng từng tham gia cấy ghép tim ở nước ngoài')
                                    return 'Hãy nhập vào giới thiệu!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.home_work,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Địa chỉ trung tâm: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initCenterAddreess,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    border: textFeildBorder,
                                    enabledBorder: textFeildBorder,
                                    focusedBorder: textFeildBorder,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor)),
                                    disabledBorder: textFeildBorder,
                                    hintText:
                                        controller.newDoctor.centeraddress,
                                    hintStyle: textStyle),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.centeraddress = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.centeraddress ==
                                          'VD: 331 Đường Ba Tháng Hai, Hưng lợi')
                                    return 'Hãy nhập vào địa chỉ trung tâm!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_rounded,
                                      color: primaryColor),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      'Địa chỉ: ',
                                      style: textStyle,
                                    ),
                                  ),
                                  DropdownButton<AddressModel>(
                                    items: controller.listAddress
                                        .map((AddressModel value) {
                                      return DropdownMenuItem<AddressModel>(
                                        value: value,
                                        child: Text(
                                          value.name!,
                                          style: informationText,
                                        ),
                                      );
                                    }).toList(),
                                    menuMaxHeight: 150,
                                    onChanged: (value) {
                                      controller.hint = value!.name;
                                      controller.newDoctor.addressRef =
                                          value.reference;
                                    },
                                    hint: DropdownMenuItem<String>(
                                      value: controller.hint,
                                      child: Text(
                                        controller.hint,
                                        style: informationText,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              CustomButton(
                                  width: 96,
                                  height: 46,
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate())
                                      return;
                                    _formKey.currentState!.save();
                                    FocusScope.of(context).unfocus();
                                    controller.updateDoctorInfo();
                                    controller.loadData();
                                    Get.back();
                                  },
                                  text: 'Xong')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
