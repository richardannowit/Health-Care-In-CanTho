import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 22,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        radius: 30,
        onTap: () => Get.back(),
        child: Image.asset(
          'assets/images/arrow.png',
          scale: 2.1,
        ),
      ),
    );
  }
}
