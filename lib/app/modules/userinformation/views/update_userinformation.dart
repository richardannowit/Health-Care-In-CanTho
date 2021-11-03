import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_appbar.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/modules/userinformation/controllers/userinformation_controller.dart';
import 'package:flutter_healthcare/app/modules/userinformation/views/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class UpdateUserInformationView extends StatelessWidget {
  UpdateUserInformationView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textFeildBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor));
  final UserinformationController controller = Get.find();

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
          )),
        ),
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: FloatingActionButton.extended(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              _formKey.currentState!.save();
              FocusScope.of(context).unfocus();
              controller.updateUserInfo();
              controller.loadData();
              Get.back();
            },
            label: Icon(Icons.done),
            backgroundColor: primaryColor,
          ),
        ));
  }

  Widget buildView(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          CustomAppBar(title: ''),
          Container(
            height: 212,
            margin: EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    textInputAction: TextInputAction.next,
                    style: informationText,
                    initialValue: controller.initName,
                    onSaved: (value) {
                      if (value != '') controller.newUserInfo.name = value;
                    },
                    validator: (value) {
                      if (value == '' &&
                          controller.newUserInfo.name == 'Ex: Nguyen Van A')
                        return 'Hãy nhập vào tên của bạn!';
                    },
                    decoration: InputDecoration(
                      hintText: controller.newUserInfo.name,
                      hintStyle: keyText,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      border: textFeildBorder,
                      enabledBorder: textFeildBorder,
                      focusedBorder: textFeildBorder,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: secondaryColor)),
                      disabledBorder: textFeildBorder,
                    ),
                  ),
                ),
                Text(
                  controller.userInfo.email ?? "",
                  style: informationText,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: 380,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 125,
                            child: Text(
                              'SĐT',
                              style: keyText,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: controller.initPhone,
                              style: informationText,
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                if (value != '')
                                  controller.newUserInfo.phone = value;
                              },
                              validator: (value) {
                                if (value == '' &&
                                    controller.newUserInfo.phone ==
                                        'Ex: 0971002636')
                                  return 'Hãy nhập vào số điện thoại của bạn!';
                                if (value != '' &&
                                    !GetUtils.isPhoneNumber(value!)) {
                                  return 'Số điện thoại không hợp lệ!';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: controller.newUserInfo.phone,
                                hintStyle: keyText,
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
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 125,
                            child: Text(
                              'Chiều cao',
                              style: keyText,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              style: informationText,
                              textInputAction: TextInputAction.next,
                              initialValue: controller.initHeight,
                              onSaved: (value) {
                                if (value != '')
                                  controller.newUserInfo.height =
                                      double.tryParse(value!);
                              },
                              validator: (value) {
                                if (value != '') if (double.tryParse(value!)! <=
                                        0 ||
                                    double.tryParse(value)! >= 250)
                                  return 'Chiều cao không hợp lệ!';
                              },
                              decoration: InputDecoration(
                                hintText:
                                    controller.newUserInfo.height.toString(),
                                hintStyle: keyText,
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
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text('(cm)', style: keyText))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 125,
                            child: Text(
                              'Cân nặng',
                              style: keyText,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: controller.initWeight,
                              style: informationText,
                              textInputAction: TextInputAction.next,
                              onSaved: (value) {
                                controller.newUserInfo.weight =
                                    double.tryParse(value!);
                              },
                              validator: (value) {
                                if (value != '') if (double.tryParse(value!)! <=
                                    0) return 'Cân nặng không hợp lệ!';
                              },
                              decoration: InputDecoration(
                                hintText:
                                    controller.newUserInfo.weight.toString(),
                                hintStyle: keyText,
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
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text('(Kg)', style: keyText))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 125,
                            child: Text(
                              'Giới tính',
                              style: keyText,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Obx(
                                  () => Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                            color: primaryColor,
                                            width: 1,
                                          ),
                                          color: controller.bgCheckBox),
                                      child: InkWell(
                                        onTap: () {
                                          controller.sex = !controller.sex;
                                          if (controller.sex) {
                                            controller.bgCheckBox =
                                                primaryColor;
                                            controller.newUserInfo.sex = 'Nam';
                                          } else {
                                            controller.bgCheckBox =
                                                Colors.white;
                                            controller.newUserInfo.sex = 'Nữ';
                                          }
                                        },
                                        child: controller.sex
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.check_box_outline_blank,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    'Nam',
                                    style: informationText,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 125,
                            child: Text(
                              'Địa chỉ',
                              style: keyText,
                            ),
                          ),
                          Obx(() => DropdownButton<AddressModel>(
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
                                onChanged: (value) {
                                  controller.hint = value!.name;
                                  controller.newUserInfo.addressRef =
                                      value.reference;
                                },
                                menuMaxHeight: 150,
                                hint: DropdownMenuItem<String>(
                                    value: controller.hint,
                                    child: Text(controller.hint,
                                        style: informationText)),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 125,
                            child: Text(
                              'Ngày sinh',
                              style: keyText,
                            ),
                          ),
                          TextButton(
                              onPressed: () => pickDate(context),
                              child: Text(
                                controller.getText(),
                                style: informationText,
                              ))
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ));
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (newDate == null) return;
    controller.date = newDate;
  }
}
