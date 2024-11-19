import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CustomMultiDropdown<T> extends StatelessWidget {
  final String label;
  final List<DropdownItem<String>> items;
  final MultiSelectController<String> controller;
  final String? Function(List<DropdownItem<String>>?)? validator;
  final Function(List<String>)? onSelectionChange;

  const CustomMultiDropdown({
    Key? key,
    required this.label,
    required this.items,
    required this.controller,
    this.validator,
    this.onSelectionChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiDropdown<String>(
      items: items,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: true,
      chipDecoration: const ChipDecoration(
        backgroundColor: primaryColor, // Warna primary
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        wrap: true,
        runSpacing: 10,
        spacing: 10,
        deleteIcon: Icon(Icons.close, color: Colors.white, size: 15),
      ),
      fieldDecoration: FieldDecoration(
        backgroundColor: Colors.grey[200],
        hintText: label,
        labelStyle: const TextStyle(
          color: Color(0xff8D95A1),
        ),
        showClearIcon: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownDecoration: const DropdownDecoration(
        marginTop: 2,
        maxHeight: 500,
      ),
      dropdownItemDecoration: const DropdownItemDecoration(
        selectedIcon: Icon(
          Icons.check_box,
        ),
      ),
      validator: validator,
      onSelectionChange: (selectedItems) {
        if (onSelectionChange != null) {
          onSelectionChange!(selectedItems);
        }
        debugPrint("OnSelectionChange: $selectedItems");
      },
    );
  }
}
