import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/data/helper/constants.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/conversation_controller.dart';

class ConversationView extends GetView<ConversationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: CircleAvatar(
                backgroundColor: primaryColor,
                child: Image.asset(
                  'assets/images/doctor2.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                Constants.doctorName,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          radius: 30,
          onTap: () => Get.back(),
          child: Image.asset(
            'assets/images/arrow.png',
            scale: 2.2,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Background(height: MediaQuery.of(context).size.height),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      hintText: "Message ...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: primaryColor),
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
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Image.asset(
                        'assets/images/send.png',
                        scale: 1.8,
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
            var timedata = (controller.messages[currentIndex]["time"]);
            final time = DateTime.fromMillisecondsSinceEpoch(timedata);
            final formatTime = DateTimeHelpers.dateTimeToTime(time);
            return Constants.myName ==
                    controller.messages[currentIndex]["sendBy"]
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formatTime,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 0, right: 16),
                        alignment: Constants.myName ==
                                controller.messages[currentIndex]["sendBy"]
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(left: 8),
                            padding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                topLeft: Radius.circular(24),
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                              color: primaryColor,
                            ),
                            child: Text(
                                controller.messages[currentIndex]["message"]
                                    .toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ))),
                      ),
                    ],
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
                              'assets/images/doctor2.png',
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
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24),
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
                      Text(
                        formatTime,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
