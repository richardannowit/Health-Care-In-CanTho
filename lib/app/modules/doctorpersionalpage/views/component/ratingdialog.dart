import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/controllers/doctorpersionalpage_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RatingDialog extends StatelessWidget {
  RatingDialog({Key? key, this.size, required this.controller, this.rating})
      : super(key: key);
  final Size? size;
  final double? rating;
  final DoctorpersionalpageController controller;
  final textFeildBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: primaryColor),
  );
  Widget build(BuildContext context) {
    return Obx(() => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(12.0))), //this right here
          child: Container(
            child: Stack(
              children: [
                Positioned(
                  top: -100,
                  right: 40,
                  child: Image.asset("assets/images/background-large.png"),
                ),
                Positioned(
                  top: 200,
                  left: 40,
                  child: Image.asset("assets/images/background-small.png"),
                ),
                Positioned(
                  bottom: 200,
                  right: 40,
                  child: Image.asset("assets/images/background-small.png"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 252,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    child: Image(
                                  image: AssetImage(
                                      'assets/images/avt_doctor.png'),
                                )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Hãy đánh giá!',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Số sao',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                ),
                                RatingBar.builder(
                                    itemSize: 40,
                                    allowHalfRating: true,
                                    initialRating: rating!,
                                    itemBuilder: (context, _) =>
                                        Icon(Icons.star, color: Colors.amber),
                                    onRatingUpdate: (rating) {
                                      controller.score = rating;
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                hintText: 'Đánh giá của bạn..',
                                hintStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                border: textFeildBorder,
                                enabledBorder: textFeildBorder,
                                focusedBorder: textFeildBorder,
                                disabledBorder: textFeildBorder,
                              ),
                              onChanged: (value) {
                                controller.content = value;
                              },
                            ),
                          ),
                          Text(controller.text,
                              style: TextStyle(color: Colors.red)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: CustomButton(
                                      backgroundColor: secondaryColor,
                                      width: 90,
                                      height: 36,
                                      onPressed: () {
                                        Get.back();
                                        controller.text = '';
                                        controller.changeRxRating();
                                      },
                                      text: 'Hủy bỏ')),
                              Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: CustomButton(
                                    height: 36,
                                    width: 90,
                                    onPressed: () {
                                      if (controller.score == 0 ||
                                          controller.content == '') {
                                        controller.text = 'Nhập vào đánh giá!';
                                      } else {
                                        controller.text = '';
                                        controller.upReview();
                                        Get.back();
                                        Get.snackbar('Thành công!',
                                            'Cảm ơn về đánh giá của bạn, chúng tôi sẽ dựa vào đó để cải tiến chất lượng phục vụ!!');
                                      }
                                    },
                                    text: 'Đồng ý',
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
