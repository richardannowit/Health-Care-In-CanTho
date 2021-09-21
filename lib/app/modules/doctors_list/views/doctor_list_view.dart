import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/models/doctor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../controllers/doctor_list_controller.dart';

class DoctorsListView extends GetView<DoctorListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Doctor List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
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
              child: Obx(() => _buildDoctorList(controller.districtName.value)),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<Doctor>> _buildDoctorList(district) {
    return FutureBuilder(
      future: controller.databaseMethods.getDoctorsByDistrict(district),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var doctors = snapshot.data as List<Doctor>;
          if (doctors.length == 0)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Doctor list are empty'),
                ],
              ),
            );
          else {
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/avt_doctor.png',
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '${doctors[index].name}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text('${doctors[index].specialist}'),
                          ),
                          RatingBar.builder(
                              itemSize: 16,
                              allowHalfRating: true,
                              initialRating: doctors[index].rating,
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                              itemPadding:
                                  const EdgeInsets.fromLTRB(0, 6, 6, 16)),
                        ],
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
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    controller.currentIndex.value = index;
                    print('$index ' + 'và' + '$controller.currentIndex.value');
                    controller.changeCategories(districts[index].name);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '${districts[index].name}',
                      style: TextStyle(
                          color: index == controller.currentIndex.value
                              ? Colors.white
                              : Colors.black),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: controller.currentIndex.value == index
                            ? Colors.amber
                            : Colors.white),
                  ),
                )),
          );
        });
  }
}
