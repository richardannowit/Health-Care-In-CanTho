import 'package:flutter_healthcare/app/data/models/district.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class DoctorListController extends GetxController {
  RxString districtName = 'Ninh Kiều'.obs;
  District district = Get.put(District());
  DatabaseMethods databaseMethods = Get.put(DatabaseMethods());
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  // void changeCategories(index) {
  //   currentIndex(index);
  //   getDoctorsByDistrict(index);
  // }

  changeCategories(var value) {
    this.districtName.value = value;
  }
}
