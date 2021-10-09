import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_healthcare/app/data/helper/constants.dart';
import 'package:flutter_healthcare/app/data/services/database.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  TextEditingController messageEditingController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final bool sendByMe = false;

  Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection("chatRoom")
      .doc(Constants.chatRoomId)
      .collection("chats")
      .snapshots();

  StreamSubscription? messageSub;

  final databaseReference = FirebaseDatabase.instance
      .reference()
      .child("chatRoom")
      .child(Constants.chatRoomId)
      .child("chats");

  final messages = [].obs;

  sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addMessage(Constants.chatRoomId, chatMessageMap);
      messageEditingController.text = "";
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    messageSub = messageStream.listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          messages.add(element.doc.data());
        }
      });
    });
  }

  @override
  void onClose() {
    messageEditingController.dispose();
    messageSub?.cancel();
  }
}
