import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/modules/doctorpersionalpage/views/constants.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard(
      {Key? key,
      this.image,
      this.content,
      this.score,
      this.date,
      this.name,
      required this.size})
      : super(key: key);
  final String? image, content, date, name;
  final double? score;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: size.width - 40,
      padding: EdgeInsets.all(10),
      decoration: cardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                        child: Image(
                      image: AssetImage('assets/images/avt_user.png'),
                    )),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name!,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                              )),
                          Text(
                            date!,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber[200],
                    ),
                    Text('(' + score!.toString() + ')', style: txtStyle),
                  ],
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                content!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: txtStyle,
              )),
        ],
      ),
    );
  }
}
