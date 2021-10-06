import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/controllers/doctorinformation_controller.dart';
import 'package:get/get.dart';

import 'constants.dart';

class UpdateView extends StatelessWidget {
  UpdateView({Key? key}) : super(key: key);

  final DoctorinformationController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 600,
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
                      TextFormField()
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
                    TextFormField()
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
                    TextFormField()
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
                    TextFormField()
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
                    TextFormField()
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
                          items:
                              controller.listAddress.map((AddressModel value) {
                            return DropdownMenuItem<AddressModel>(
                              value: value,
                              child: Text(value.name!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.hint = value!.name;
                            ;
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
                Container(
                  width: 100,
                  height: 40,
                  margin: EdgeInsets.only(top: 0),
                  child: TextButton(
                      onPressed: () {
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
    ));
  }
}
