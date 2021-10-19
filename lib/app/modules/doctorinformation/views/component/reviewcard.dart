import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard(
      {Key? key, this.image, this.content, this.score, this.date, this.name})
      : super(key: key);
  final String? image, content, date, name;
  final double? score;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 350,
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
                          Text(name!, style: textStyle),
                          Text(
                            date!,
                            style: txtStyle,
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
              margin: EdgeInsets.only(top: 10),
              child: Text(
                content!,
                style: txtStyle,
              )),
        ],
      ),
    );
  }
}
