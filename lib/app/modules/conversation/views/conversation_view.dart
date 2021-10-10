import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/data/helper/constants.dart';
import 'package:get/get.dart';
import '../controllers/conversation_controller.dart';

class ConversationView extends GetView<ConversationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.doctorName),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 70),
            child: ChatMessageList(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageEditingController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "Message ...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                    onTap: () {
                      controller.sendMessage();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ChatMessageList() {
    return Obx(
      () => ListView.builder(
          reverse: true,
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            int? currentIndex = controller.messages.length - index - 1;
            return Constants.myName ==
                    controller.messages[currentIndex]["sendBy"]
                ? Container(
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 8),
                    alignment: Constants.myName ==
                            controller.messages[currentIndex]["sendBy"]
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 30),
                        padding: EdgeInsets.only(
                            top: 12, bottom: 12, left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            topLeft: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                          ),
                          color: Colors.white,
                        ),
                        child: Text(
                            controller.messages[currentIndex]["message"]
                                .toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ))),
                  )
                : Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          height: 40,
                          width: 40,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/bs_login.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 8, right: 0),
                          alignment: controller.sendByMe
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(right: 30),
                            padding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                ),
                                color: Colors.white),
                            child: Text(
                                controller.messages[currentIndex]["message"]
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                          )),
                    ],
                  );
          }),
    );
  }
}
