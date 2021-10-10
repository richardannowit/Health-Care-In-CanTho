import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/controllers/doctorinformation_controller.dart';
import 'package:get/get.dart';

import 'constants.dart';

class UpdateView extends StatelessWidget {
  UpdateView({Key? key}) : super(key: key);

  final DoctorinformationController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
            body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 640,
                decoration: formUpdateStyle,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Update your information',
                        style: textStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Name: '),
                                )
                              ],
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: controller.newDoctor.name),
                              onSaved: (value) {
                                if (value != '')
                                  controller.newDoctor.name = value;
                              },
                              validator: (value) {
                                if (value == '' &&
                                    controller.newDoctor.name ==
                                        'Ex: Vo Tu Thien')
                                  return 'The name field cannot be empty!';
                              },
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('Numberphone: '),
                              )
                            ],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: controller.newDoctor.phone),
                            onSaved: (value) {
                              if (value != '')
                                controller.newDoctor.phone = value;
                            },
                            validator: (value) {
                              if (value == '' &&
                                  controller.newDoctor.phone ==
                                      'Ex: 0812305346')
                                return 'The phone field cannot be empty!';
                              if (value != '' &&
                                  !GetUtils.isPhoneNumber(value!))
                                return 'Incorrect!';
                            },
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.architecture,
                                color: Colors.blue,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('Specialist: '),
                              )
                            ],
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: controller.newDoctor.specialist),
                            onSaved: (value) {
                              if (value != '')
                                controller.newDoctor.specialist = value;
                            },
                            validator: (value) {
                              if (value == '' &&
                                  controller.newDoctor.specialist ==
                                      'Ex: Heart')
                                return 'The specialist field cannot be empty!';
                            },
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.app_registration_rounded,
                                color: Colors.blue,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('About me: '),
                              )
                            ],
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: controller.newDoctor.about),
                            onSaved: (value) {
                              if (value != '')
                                controller.newDoctor.about = value;
                            },
                            validator: (value) {
                              if (value == '' &&
                                  controller.newDoctor.about ==
                                      'Ex: Renowned doctor who participated in heart transplants abroad')
                                return 'The about field cannot be empty!';
                            },
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.home_work,
                                color: Colors.blue,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text('Center address: '),
                              )
                            ],
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: controller.newDoctor.centeraddress),
                            onSaved: (value) {
                              if (value != '')
                                controller.newDoctor.centeraddress = value;
                            },
                            validator: (value) {
                              if (value == '' &&
                                  controller.newDoctor.centeraddress ==
                                      'Ex: 331 Ba Thang Hai Street, Hung Loi')
                                return 'The center adress field cannot be empty!';
                            },
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_rounded,
                                  color: Colors.blue),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                menuMaxHeight: 150,
                                onChanged: (value) {
                                  controller.hint = value!.name;
                                  controller.newDoctor.addressRef =
                                      value.reference;
                                },
                                hint: DropdownMenuItem<String>(
                                  value: controller.hint,
                                  child: Text(controller.hint),
                                ),
                              )
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
                              controller.updateDoctorInfo();
                              controller.loadData();
                              Get.back();
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )));
  }
}
