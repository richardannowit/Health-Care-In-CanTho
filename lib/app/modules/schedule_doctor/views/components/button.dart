import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  ButtonCustom({
    Key? key,
    required this.text,
    required this.onPress,
    required this.color,
  }) : super(key: key);

  final String text;
  final Function onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      child: InkWell(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        onTap: () => onPress,
      ),
    );
  }
}
