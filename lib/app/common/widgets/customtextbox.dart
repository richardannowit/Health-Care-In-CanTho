import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';

class CustomTextBox extends StatelessWidget {
  CustomTextBox({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
    this.onSaved,
    this.validator,
    this.icon,
    this.inputKey,
    this.obscureText,
    this.keyBoardType,
  }) : super(key: key);

  final String text;
  final double height, width;
  final TextInputType? keyBoardType;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final IconData? icon;
  final bool? obscureText;
  final Key? inputKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          border: Border.all(color: primaryColor)),
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: EdgeInsets.only(right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
              visible: (icon != null),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Icon(icon ?? Icons.person, color: greyColor),
              )),
          Expanded(
              child: TextFormField(
            onSaved: onSaved,
            validator: validator,
            keyboardType: keyBoardType,
            key: inputKey,
            obscureText: obscureText ?? false,
            decoration: new InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 14, bottom: 11, top: 11, right: 14),
                hintText: text,
                hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ))
        ],
      ),
    );
  }
}
