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
  final bool isEnabled; // Menambahkan properti untuk kontrol enabled

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.isPassword = false,
    this.isNumber = false,
    this.showPassword,
    this.onTogglePasswordVisibility,
    this.isEnabled = true, // Defaultnya adalah true (aktif)
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: showPassword == true ? false : isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      enabled: isEnabled, // Mengatur enabled sesuai parameter
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: isEnabled ? const Color(0xff8D95A1) : Colors.grey,
        ),
        filled: true,
        fillColor: isEnabled ? Colors.grey[200] : Colors.grey[300],
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
                onPressed: isEnabled
                    ? onTogglePasswordVisibility
                    : null, // Hanya aktif jika isEnabled true
              )
            : null,
      ),
      validator: validator,
    );
  }
}
