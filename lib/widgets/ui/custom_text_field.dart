import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isNumber;
  final bool? showPassword; // Menerima nilai showPassword dari controller
  final VoidCallback?
      onTogglePasswordVisibility; // Callback untuk toggle password

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.isPassword = false,
    this.isNumber = false,
    this.showPassword, // Menerima nilai showPassword
    this.onTogglePasswordVisibility, // Callback untuk toggle
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: showPassword == true ? false : isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xff8D95A1),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  showPassword == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed:
                    onTogglePasswordVisibility, // Memanggil fungsi toggle
              )
            : null,
      ),
      validator: validator,
    );
  }
}
