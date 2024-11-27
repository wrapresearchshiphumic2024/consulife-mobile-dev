import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color primaryColor;
  final VoidCallback onPressed;
  final String buttonText;

  const CustomElevatedButton({
    Key? key,
    required this.primaryColor,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          elevation: 5, // Menambahkan efek bayangan
          shadowColor: Colors.black.withOpacity(0.2), // Warna bayangan
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
