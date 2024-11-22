import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonBack extends StatelessWidget {
  final void Function()? onBackPressed;
  const ButtonBack({super.key, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/images/back.png',
        height: 24,
        width: 24,
      ),
      onPressed: onBackPressed ?? () => Get.back(),
    );
  }
}
