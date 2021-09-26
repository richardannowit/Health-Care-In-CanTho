import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/components/timeline_card.dart';

class TimeLineList extends StatelessWidget {
  const TimeLineList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                child: Text(
                  "Your schedule",
                  style: TextStyle(
                    color: Color(0xff016565),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      //
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Color(0xff443BAD),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 600, minHeight: 100.0),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, index) {
                return TimeLineCard();
              },
            ),
          ),
        )
      ],
    );
  }
}
