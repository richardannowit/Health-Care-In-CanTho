import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/widgets/loaders/color_loader_3.dart';

import '../constant.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          // color: primaryColor.withOpacity(0.1),
          ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Vui lòng đợi trong giây lát...",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            ColorLoader3(
              radius: 25,
              dotRadius: 7,
            ),
          ],
        ),
      ),
    );
  }
}
