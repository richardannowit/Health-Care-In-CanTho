import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/views/updateview.dart';
import 'package:flutter_healthcare/app/modules/userinformation/views/update_userinformation.dart';
import 'package:get/get.dart';

class UserinformationController extends GetxController {
  var isFrist = Get.arguments;
  late List<AddressModel> listAddress;
  late AddressModel address;
  late String dateOfBirth,
      addressName,
      initName,
      initHeight,
      initWeight,
      infor = "",
      initPhone;
  final DatabaseMethods databaseMethods = Get.put(DatabaseMethods());
  final String userID = FirebaseAuth.instance.currentUser!.uid;
  UserModel newUserInfo = new UserModel();
  bool isUpdate = false;

  Rx<UserModel> _userInfo = new UserModel().obs;
  UserModel get userInfo => _userInfo.value;
  set userInfo(value) => _userInfo.value = value;

  Rx<String> _userName = '...'.obs;
  String get userName => _userName.value;
  set userName(value) => _userName.value = value;

  Rx<Color> _bgCheckBox = Colors.white.obs;
  Color get bgCheckBox => _bgCheckBox.value;
  set bgCheckBox(value) => _bgCheckBox.value = value;

  RxBool _loading = true.obs;
  bool get loading => _loading.value;
  set loading(value) => _loading.value = value;

  RxBool _sex = true.obs;
  bool get sex => _sex.value;
  set sex(value) => _sex.value = value;

  RxString _hint = 'Ninh Kiều'.obs;
  String get hint => _hint.value;
  set hint(value) => _hint.value = value;

  var _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(value) => _date.value = value;

  String getText() {
    return '${date.day}/${date.month}/${date.year}';
  }

  loadData() async {
    loading = true;
    listAddress = await databaseMethods.getDistricts();
    userInfo = await databaseMethods.getUserByUID(userID);
    removeNullField();
    isFirstEnterInformation();
    infor = userInfo.sex! +
        " - " +
        userInfo.height!.toString() +
        " cm - " +
        userInfo.weight!.toString() +
        " kg";
    loading = false;
  }

  isFirstEnterInformation() {
    if (isFrist != null) {
      makeHint();
      Get.to(UpdateUserInformationView());
      isFrist = null;
    }
  }

  removeNullField() {
    if (userInfo.email == null) {
      userInfo.email = FirebaseAuth.instance.currentUser!.email;
    }
    if (userInfo.sex == null) {
      userInfo.sex = 'Không';
    }
    if (userInfo.name == null) {
      userName = 'Chờ bạn cập nhật';
    } else {
      userName = userInfo.name;
    }
    if (userInfo.height == null) {
      userInfo.height = 0;
    }
    if (userInfo.weight == null) {
      userInfo.weight = 0;
    }
    if (userInfo.phone == null) {
      userInfo.phone = 'Chờ bạn cập nhật';
    }

    if (userInfo.dateOfBirth == null) {
      dateOfBirth = 'Chờ bạn cập nhật';
    } else {
      dateOfBirth = DateTimeHelpers.timestampsToDate(userInfo.dateOfBirth!);
    }
    if (userInfo.address == null) {
      addressName = 'Chờ bạn cập nhật';
    } else {
      if (userInfo.address!.name == 'NULL') {
        addressName = 'Chờ bạn cập nhật';
      } else {
        isUpdate = true;
        addressName = userInfo.address!.name! + ', Cần Thơ';
      }
    }
  }

  makeHint() {
    newUserInfo.addressRef = listAddress[0].reference;
    hint = listAddress[0].name;
    if (userInfo.sex == 'Không') {
      newUserInfo.sex = 'Nam';
      sex = true;
      bgCheckBox = primaryColor;
    } else {
      newUserInfo.sex = userInfo.sex;
      if (userInfo.sex == 'Nam') {
        sex = true;
        bgCheckBox = primaryColor;
      } else {
        sex = false;
        bgCheckBox = Colors.white;
      }
    }
    if (userInfo.name == null) {
      newUserInfo.name = 'Ex: Nguyen Van A';
      initName = '';
    } else {
      newUserInfo.name = userInfo.name;
      initName = userInfo.name!;
    }
    if (userInfo.height == 0) {
      newUserInfo.height = 160;
      initHeight = '';
    } else {
      newUserInfo.height = userInfo.height;
      initHeight = userInfo.height.toString();
    }
    if (userInfo.weight == 0) {
      newUserInfo.weight = 50;
      initWeight = '';
    } else {
      newUserInfo.weight = userInfo.weight;
      initWeight = userInfo.weight.toString();
    }
    if (userInfo.phone == 'Chờ bạn cập nhật') {
      newUserInfo.phone = 'Ex: 0971002636';
      initPhone = '';
    } else {
      newUserInfo.phone = userInfo.phone;
      initPhone = userInfo.phone!;
    }
    if (userInfo.address != null) {
      if (userInfo.address!.name != 'NULL') {
        newUserInfo.addressRef = userInfo.address!.reference;
        hint = userInfo.address!.name;
      }
    }
    if (userInfo.dateOfBirth != null) {
      date = DateTime.fromMillisecondsSinceEpoch(
          userInfo.dateOfBirth!.millisecondsSinceEpoch);
    }
  }

  updateUserInfo() {
    newUserInfo.email = FirebaseAuth.instance.currentUser!.email;
    newUserInfo.dateOfBirth = Timestamp.fromDate(date);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .set(newUserInfo.toJson());
    isUpdate = true;
  }

  final count = 0.obs;
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
  void increment() => count.value++;
}
