import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_healthcare/app/data/helper/constants.dart';
import 'package:flutter_healthcare/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_healthcare/app/data/models/district.dart';
import 'package:flutter_healthcare/app/data/models/user.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DoctorListController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  RxString districtName = 'Bình Thuỷ'.obs;

  District district = Get.put(District());
  DatabaseMethods databaseMethods = Get.put(DatabaseMethods());
  var currentIndex = 0.obs;

  Rx<UserModel> _userInfo = new UserModel().obs;
  UserModel get userInfo => _userInfo.value;
  set userInfo(value) => _userInfo.value = value;

  Stream<QuerySnapshot>? chatRoomStream;

  Future<UserModel> getUserInfo() async {
    user = _auth.currentUser;
    if (user != null) {
      UserModel data = await databaseMethods.getUserByUID(user!.uid);
      return data;
    }
    return new UserModel();
  }

  createChatroomAndStartConversation(String userName, String name) {
    try {
      Constants.chatRoomId = getChatRoomId(Constants.myName, userName);
      List<String> users = [Constants.myName, userName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": Constants.chatRoomId,
      };

      databaseMethods.createChatroom(Constants.chatRoomId, chatRoomMap);
      Constants.doctorName = name;
      Get.toNamed(Routes.CONSERVATION);
    } catch (e) {
      print(e);
    }
  }

  getChatRoomId(String a, String b) {
    print("$b\_$a");
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getUserInfoIsLogged() async {
    Constants.myName =
        (await HelperFunctions.getUserEmailSharedPreference()) ?? '';
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      chatRoomStream = value;
    });
  }

  @override
  void onInit() async {
    super.onInit();
    await getUserInfo();
    await getUserInfoIsLogged();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  changeCategories(var value) {
    this.districtName.value = value;
  }
}
