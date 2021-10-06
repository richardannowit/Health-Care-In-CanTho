import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class UserinformationController extends GetxController {
  late List<AddressModel> listAddress;
  late AddressModel address;
  late String dateOfBirth, addressName;
  final DatabaseMethods databaseMethods = Get.put(DatabaseMethods());
  final String userID = FirebaseAuth.instance.currentUser!.uid;
  UserModel newUserInfo = new UserModel();
  bool isUpdate = true, updating = false;

  Rx<UserModel> _userInfo = new UserModel().obs;
  UserModel get userInfo => _userInfo.value;
  set userInfo(value) => _userInfo.value = value;

  Rx<String> _userName = '...'.obs;
  String get userName => _userName.value;
  set userName(value) => _userName.value = value;

  RxBool _flag = true.obs;
  bool get flag => _flag.value;
  set flag(value) => _flag.value = value;

  RxBool _visible = true.obs;
  bool get visible => _visible.value;
  set visible(value) => _visible.value = value;

  RxString _hint = 'Ninh Kieu'.obs;
  String get hint => _hint.value;
  set hint(value) => _hint.value = value;

  var _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(value) => _date.value = value;

  String getText() {
    return '${date.day}/${date.month}/${date.year}';
  }

  loadData() async {
    listAddress = await databaseMethods.getDistricts();
    userInfo = await databaseMethods.getUserByUID(userID);
    removeNullField();
  }

  removeNullField() {
    if (userInfo.email == null) {
      isUpdate = false;
      userInfo.email = FirebaseAuth.instance.currentUser!.email;
    } else {}
    if (userInfo.name == null) {
      userName = 'Waiting for your update';
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
      userInfo.phone = 'Waiting for your update';
    }

    if (userInfo.dateOfBirth == null) {
      dateOfBirth = 'Waiting for your update';
    } else {
      dateOfBirth = DateTimeHelpers.timestampsToDate(userInfo.dateOfBirth!);
    }
  }

  makeHint() {
    updating = true;
    newUserInfo.addressRef = listAddress[0].reference;
    hint = listAddress[0].name;
    if (userInfo.name == null) {
      newUserInfo.name = 'Ex: Nguyen Van A';
    } else {
      newUserInfo.name = userInfo.name;
    }
    if (userInfo.height == 0) {
      newUserInfo.height = 1.6;
    } else {
      newUserInfo.height = userInfo.height;
    }
    if (userInfo.weight == 0) {
      newUserInfo.weight = 50;
    } else {
      newUserInfo.weight = userInfo.weight;
    }
    if (userInfo.phone == 'Waiting for your update') {
      newUserInfo.phone = 'Ex: 0971002636';
    } else {
      newUserInfo.phone = userInfo.phone;
    }
    if (userInfo.address != null) {
      if (userInfo.address!.name != 'null') {
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
    updating = false;
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
