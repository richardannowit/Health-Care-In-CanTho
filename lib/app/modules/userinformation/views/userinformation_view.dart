import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/views/constants.dart';
import 'package:flutter_healthcare/app/modules/userinformation/views/constants.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/userinformation_controller.dart';

class UserinformationView extends GetView<UserinformationController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    controller.loadData();
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: !controller.visible,
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 10, right: 30, bottom: 20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (controller.updating) {
                              //do nothing
                            } else {
                              if (!controller.isUpdate) {
                                Get.snackbar('Please update your information',
                                    'To use other features please update your information');
                              } else {
                                Get.offAndToNamed(Routes.HOME);
                              }
                            }
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Information",
                            style: textStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: controller.visible,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: inforStyle,
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/avt_doctor.png'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child:
                                    Text(controller.userName, style: textStyle),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              child: controller.flag
                                  ? informationView(context)
                                  : changeInformationView(context)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget informationView(BuildContext context) {
    if (controller.userInfo.email == null) {
      return Container(
        key: Key('3'),
        height: 460,
      );
    }
    return Container(
      key: Key('1'),
      width: MediaQuery.of(context).size.width - 40,
      height: 460,
      decoration: inforStyle,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Your information', style: textStyle),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.email, color: Colors.blue),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Email:'),
                      )
                    ],
                  ),
                ),
                Text(controller.userInfo.email!, style: textStyle),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('Sex:'),
                    ),
                    Text(
                      controller.userInfo.sex!,
                      style: textStyle,
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text('Height:'),
                          ),
                          Row(
                            children: [
                              Text(
                                controller.userInfo.height.toString(),
                                style: textStyle,
                              ),
                              Text(
                                ' m',
                                style: textStyle,
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 8),
                            child: Text('Weight:'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.userInfo.weight.toString(),
                                style: textStyle,
                              ),
                              Text(
                                ' Kg',
                                style: textStyle,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Number phone:'),
                      )
                    ],
                  ),
                ),
                Text(controller.userInfo.phone!, style: textStyle),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: Colors.blue),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Address:'),
                      )
                    ],
                  ),
                ),
                Text(controller.addressName, style: textStyle),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.date_range, color: Colors.blue),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Date of birth:'),
                      )
                    ],
                  ),
                ),
                Text(controller.dateOfBirth, style: textStyle),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
            Container(
              width: 100,
              height: 40,
              child: TextButton(
                  onPressed: () {
                    controller.flag = !controller.flag;
                    controller.visible = false;
                    controller.makeHint();
                  },
                  style: buttonStyle,
                  child: Row(
                    children: [
                      Icon(Icons.update, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget changeInformationView(BuildContext context) => Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            key: Key('2'),
            width: MediaQuery.of(context).size.width - 40,
            height: 480,
            decoration: inforStyle,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Please enter your information', style: textStyle),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.blue),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Name:'),
                            )
                          ],
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          if (value != '') controller.newUserInfo.name = value;
                        },
                        decoration: InputDecoration(
                            hintText: controller.newUserInfo.name),
                        validator: (value) {
                          if (value == '' &&
                              controller.newUserInfo.name == 'Ex: Nguyen Van A')
                            return 'The name field cannot be empty!';
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sex/Height(m)/Weight(kg):'),
                      Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: controller.sex,
                                  onChanged: (value) {
                                    if (value!) {
                                      controller.newUserInfo.sex = 'Nam';
                                    } else {
                                      controller.newUserInfo.sex = 'Nữ';
                                    }
                                    controller.sex = value;
                                  }),
                              Text('Nam')
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Container(
                                    width: 60,
                                    child: TextFormField(
                                      onSaved: (value) {
                                        if (value != '')
                                          controller.newUserInfo.height =
                                              double.tryParse(value!);
                                      },
                                      decoration: InputDecoration(
                                          hintText: controller
                                              .newUserInfo.height
                                              .toString()),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value !=
                                            '') if (double.tryParse(value!)! <=
                                                0 ||
                                            double.tryParse(value)! >= 2.5)
                                          return 'Incorrect';
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 60,
                              child: TextFormField(
                                  onSaved: (value) {
                                    if (value != '')
                                      controller.newUserInfo.weight =
                                          double.tryParse(value!);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: controller.newUserInfo.weight
                                          .toString()),
                                  validator: (value) {
                                    if (value !=
                                        '') if (double.tryParse(value!)! <= 0)
                                      return 'Incorrect';
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.blue),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Number phone:'),
                          )
                        ],
                      ),
                      TextFormField(
                        onSaved: (value) {
                          if (value != '') controller.newUserInfo.phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: controller.newUserInfo.phone),
                        validator: (value) {
                          if (value == '' &&
                              controller.newUserInfo.phone == 'Ex: 0971002636')
                            return 'The phone field cannot be empty!';
                          if (value != '' && !GetUtils.isPhoneNumber(value!)) {
                            return 'Incorrect!';
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, color: Colors.blue),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text('Address: '),
                          ),
                          DropdownButton<AddressModel>(
                            items: controller.listAddress
                                .map((AddressModel value) {
                              return DropdownMenuItem<AddressModel>(
                                value: value,
                                child: Text(value.name!),
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
                              child: Text(controller.hint),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range, color: Colors.blue),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text('Date of birth: '),
                          ),
                          TextButton(
                              onPressed: () => pickDate(context),
                              child: Text(controller.getText()))
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    margin: EdgeInsets.only(top: 0),
                    child: TextButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          _formKey.currentState!.save();
                          FocusScope.of(context).unfocus();
                          controller.flag = !controller.flag;
                          controller.visible = true;
                          controller.updateUserInfo();
                          controller.loadData();
                        },
                        style: buttonStyle,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Icon(Icons.done, color: Colors.white),
                            ),
                            Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

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
