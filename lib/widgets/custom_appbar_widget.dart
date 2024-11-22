import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? backButtonImage; // Path gambar untuk tombol kembali
  final VoidCallback?
      onBackPressed; // Fungsi yang dipanggil saat tombol kembali ditekan
  final Color backgroundColor; // Warna latar belakang AppBar
  final double elevation; // Tingkat elevasi AppBar

  const CustomAppBar({
    super.key,
    this.backButtonImage = 'assets/images/back.png',
    this.onBackPressed,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset(
          backButtonImage!,
          height: 24,
          width: 24,
        ),
        onPressed: onBackPressed ?? () => Get.back(),
      ),
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
