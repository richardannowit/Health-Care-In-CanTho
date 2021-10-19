import 'package:flutter/material.dart';

class TimeSelectButton extends StatelessWidget {
  TimeSelectButton({
    Key? key,
    required this.height,
    required this.time,
    required this.textColor,
    required this.borderColor,
    required this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  final double height;
  final String time;
  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
