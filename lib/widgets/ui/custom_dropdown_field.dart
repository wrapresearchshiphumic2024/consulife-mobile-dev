import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final T? value;
  final String labelText;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isEnabled; // Menambahkan properti untuk kontrol enabled

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.labelText,
    required this.items,
    this.onChanged,
    this.validator,
    this.isEnabled = true, // Defaultnya adalah true (aktif)
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
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
      ),
      items: isEnabled
          ? items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList()
          : [
              DropdownMenuItem<T>(
                value: value,
                child: Text(value != null ? value.toString() : '-'),
              ),
            ], // Tetap menampilkan nilai terpilih saat tidak aktif
      onChanged: isEnabled
          ? onChanged
          : null, // Nonaktifkan perubahan jika isEnabled false
      validator: isEnabled
          ? validator
          : null, // Nonaktifkan validasi jika isEnabled false
    );
  }
}
