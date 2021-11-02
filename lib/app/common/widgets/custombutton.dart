import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.text,
    this.borderRadius,
    this.backgroundColor,
    this.fontSize,
    this.foregroundColor,
  }) : super(key: key);

  final String text;
  final double height, width;
  final GestureTapCallback onPressed;
  final double? borderRadius, fontSize;
  final Color? backgroundColor, foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(backgroundColor ?? primaryColor),
          foregroundColor:
              MaterialStateProperty.all<Color>(foregroundColor ?? Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 30),
            ),
          ),
        ),
      ),
    );
  }
}
