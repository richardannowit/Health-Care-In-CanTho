import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_appbar.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_appbar_with_actions.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_loader.dart';
import 'package:flutter_healthcare/app/data/helper/create_chatroom_helpers.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/doctor_list_controller.dart';

class DoctorsListView extends GetView<DoctorListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: 'Danh sách bác sĩ',
      ),
      body: Stack(
        children: [
          Background(height: MediaQuery.of(context).size.height),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 51,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                  child: _buildCategoriesRow(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
                  child: Obx(() =>
                      _buildDoctorList(context, controller.districtName.value)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<DoctorModel>> _buildDoctorList(context, district) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: controller.databaseMethods.getDoctorsByDistrict(district),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingScreen(height: size.height);
        else {
          var doctors = snapshot.data as List<DoctorModel>;
          if (doctors.length == 0)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rất tiếc, không có bác sĩ nào xung quanh bạn!',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          else {
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
                  child: PhysicalModel(
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    borderRadius: BorderRadius.circular(24),
                    elevation: 6,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        Get.toNamed(Routes.DOCTORPERSIONALPAGE,
                            arguments: doctors[index]);
                      },
                      child: Container(
                        height: 74,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/doctor2.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 12),
                                      child: Text(
                                        '${doctors[index].name}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 8),
                                      child: Text(
                                        'Khoa ' +
                                            '${doctors[index].specialist}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => CreateChatRoom()
                                  .createChatroomAndStartConversation(
                                      doctors[index].email.toString(),
                                      doctors[index].name.toString()),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Image.asset(
                                  'assets/images/message.png',
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }

  FutureBuilder _buildCategoriesRow() {
    return FutureBuilder(
        future: controller.databaseMethods.getDistricts(),
        builder: (context, snapshot) {
          var districts = snapshot.data ?? [];
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: districts.length,
            itemBuilder: (context, index) => Obx(() => InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    controller.currentIndex.value = index;
                    controller.changeCategories(districts[index].name);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 4),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '${districts[index].name}',
                      style: TextStyle(
                          color: index == controller.currentIndex.value
                              ? Colors.white
                              : Colors.black),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: controller.currentIndex.value == index
                            ? primaryColor
                            : Colors.white),
                  ),
                )),
          );
        });
  }
}
